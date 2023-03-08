//
//  TotalPurchasePriceViewController.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 24/02/23.
//

import UIKit

class TotalPurchasePriceViewController: UIViewController {
    
    private let config = CDConfig.shared
    
    let mainView: TotalPurchasePriceView = {
        let view = TotalPurchasePriceView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        self.view = mainView
    }

    override func viewWillAppear(_ animated: Bool) {
        mainView.setupValues(totalUS: String(self.getTotalUS()), totalBR: String(self.getTotalBR()))
    }
    
    private func getAllProducts() -> [ProductData]? {
        guard let data = config.getAllItems(with: ProductData.fetchRequest()),
                let items = data as? [ProductData] else { return nil }
        return items
    }
    
    private func getAllPrices() -> [Double] {
        guard let products = self.getAllProducts() else { return [] }
        let values = products.map { Double($0.price ?? String()) ?? 00.00 }
        return values
    }
    
    private func getTotalUS() -> Double {
        var total: Double = 00.00
        let prices = getAllPrices()
        total = prices.reduce(0) {$0 + $1}
        return total
    }
    
    private func getDolarTaxValue() -> Double {
        guard let dolarPrice = UserDefaults.standard.object(forKey: "tax_value") as? String, let dolarTaxValue = Double(dolarPrice) else {
            return 00.00
        }
        return dolarTaxValue
    }
    
    private func getIofTaxValue() -> Double {
        guard let iof = UserDefaults.standard.object(forKey: "iof_value") as? String, let iofTaxValue = Double(iof) else {
            return 1.0
        }
        return iofTaxValue/100
    }
    
        
    private func getTotalBR() -> Double {
        let products = self.getAllProducts()
        let iof = getIofTaxValue()
        let dolarTaxValue = getDolarTaxValue()
        var total = 0.0
                
        products?.forEach { product in
            guard let tax = product.state?.tax as? String, let taxValue = Double(tax),
                  let price = product.price, let priceValue = Double(price) else {
                return
            }
            let iofCard = product.card ? iof + 1 : 1.0
            let taxState = 1 + taxValue/100

            total += ((priceValue * taxState) * dolarTaxValue) * iofCard
        }
        
        return total
    }
    
}

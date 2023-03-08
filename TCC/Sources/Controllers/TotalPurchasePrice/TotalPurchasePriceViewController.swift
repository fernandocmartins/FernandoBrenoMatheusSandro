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
    
    private func getTotalBR() -> Double {
        return getTotalUS() * getDolarTaxValue()
    }
    
}

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
        var totalUS = self.getTotalUS().formatted(.currency(code: "USD"))
        var totalBR = self.getTotalBR().formatted(.currency(code: "BRZ"))
        totalBR.removeFirst(4)
        totalUS.removeFirst(4)
        mainView.setupValues(totalUS: String(totalUS), totalBR: String(totalBR))
    }
    
    private func getAllProducts() -> [ProductData]? {
        guard let data = config.getAllItems(with: ProductData.fetchRequest()),
                let items = data as? [ProductData] else { return nil }
        return items
    }
    
    private func getAllPrices() -> [Double] {
        guard let products = self.getAllProducts() else { return [] }
        let values = products.map { product -> Double in
            let price = Double(product.price ?? String()) ?? 00.00
            let tax = Double(product.state?.tax ?? String()) ?? 00.00
            var iof = 00.00
            var tax_state = 00.00
            if product.card {
                iof = (price * getIOF())
                iof = iof / 100.0
            }
            tax_state = (price * tax)
            tax_state = tax_state / 100.0
            return price + iof + tax_state
        }
        return values
    }
    
    private func getBruteValuesUS() -> [Double] {
        guard let products = self.getAllProducts() else { return [] }
        let values = products.map { product -> Double in
            let price = Double(product.price ?? String()) ?? 00.00
            return price
        }
        return values
    }
    
    
    private func getIOF() -> Double {
        guard let iof_s = UserDefaults.standard.object(forKey: "iof_value") as? String, let iof = Double(iof_s) else {
            return 00.00
        }
        return iof
    }
    
    private func getTotalBR() -> Double {
        let totalBR = getTotalUSIofTax()
        guard let dolar_s = UserDefaults.standard.object(forKey: "tax_value") as? String, let dolar = Double(dolar_s) else {
            return 00.00
        }
        let total = totalBR * dolar
        return total
    }
    
    private func getTotalUSIofTax() -> Double {
        var total: Double = 00.00
        let prices = getAllPrices()
        total = prices.reduce(0) {$0 + $1}
        return total
    }
    
    private func getTotalUS() -> Double {
        var total: Double = 00.00
        let prices = getBruteValuesUS()
        total = prices.reduce(0) {$0 + $1}
        return total
    }
    
}

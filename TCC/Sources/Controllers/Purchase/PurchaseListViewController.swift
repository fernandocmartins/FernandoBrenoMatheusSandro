//
//  PurchaseListViewController.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

final class PurchaseListViewController: UIViewController {
    
    var data: [ProductData] = {
        return []
    }() {
        didSet {
            self.setView()
            self.purchaseView.reloadData()
        }
    }
    
    lazy var purchaseView: PurchaseListView = {
        let view = PurchaseListView(delegate: self, dataSource: self)
        return view
    }()
    
    let purchaseViewEmpty: EmptyListView = {
        let view = EmptyListView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        getallItems()
    }
    
    private func getIsEmptyLister() -> Bool {
        data.isEmpty
    }
    
    private func getallItems() {
        guard let _data = CDConfig.shared.getAllItems(with: ProductData.fetchRequest()), let items = _data as? [ProductData] else { return }
        data = items
    }
    
    private func setView() {
        let _view = getIsEmptyLister() ? self.purchaseViewEmpty : self.purchaseView
        self.view = _view
    }
        
    @IBAction func addPurchase(_ sender: Any) {
        let controller = RegisterPurchaseViewController(product: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

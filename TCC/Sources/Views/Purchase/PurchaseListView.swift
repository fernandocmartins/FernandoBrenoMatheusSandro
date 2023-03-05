//
//  PurchaseListView.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

final class PurchaseListView: UITableView  {
    
    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: CGRect(), style: .plain)
        self.register(PurchaseCell.self, forCellReuseIdentifier: "listerCell")
        self.delegate = delegate
        self.dataSource = dataSource
        self.rowHeight = 100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

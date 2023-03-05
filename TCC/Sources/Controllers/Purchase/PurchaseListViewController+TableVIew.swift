//
//  PurchaseListViewController+TableVIew.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

extension PurchaseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listerCell") as? PurchaseCell else {
            return UITableViewCell()
        }
        cell.setCell(with: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = RegisterPurchaseViewController(product: data[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = data[indexPath.row]
            CDConfig.shared.deleteItem(with: item)
            data.remove(at: indexPath.row)
        }
    }
}

//
//  AdjustViewController.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

protocol AdjustSetDelegate: AnyObject {
    func setIOF(with iof:String)
    func setPrice(with price:String)
}

final class AdjustViewController: UIViewController, AdjustSetDelegate {
    
    let iofKey = "iof_value"
    let taxKey = "tax_value"
    
    lazy var mainView: AdjustView = {
        let view = AdjustView(delegate: self,
                              dataSource: self,
                              setDelegate: self,
                              iof: getIOF(),
                              price: getPrice(),
                              tableIsEmpty: data.isEmpty)
        view.backgroundColor = .white
        view.registerPriceButton.addTarget(self, action: #selector(registerPrice), for: .touchUpInside)
        return view
    }()
    
    let taxInputText: UITextField = {
        let view = UITextField()
        view.placeholder = "Imposto"
        view.borderStyle = .roundedRect
        return view
    }()
    
    var data: [StateData] = {
        return []
    }() {
        didSet {
            mainView.updateView(tableIsEmpty: data.isEmpty)
            data.isEmpty ? nil : mainView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        let tapGesture = UITapGestureRecognizer(target: self.mainView, action: #selector(UIView.endEditing))
        self.mainView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setTableItems()
    }
    
    func setTableItems() {
        guard let data = CDConfig.shared.getAllItems(with: StateData.fetchRequest()), let items = data as? [StateData] else { return }
        self.data = items
    }
    
    func getIOF() -> String {
        guard let iof = UserDefaults.standard.object(forKey: iofKey) as? String else {
            let value = "6.38"
            UserDefaults.standard.set(value, forKey: iofKey)
            return value
        }
        return iof
    }
    
    func getPrice() -> String {
        guard let tax = UserDefaults.standard.object(forKey: taxKey) as? String else {
            let value = "3.2"
            UserDefaults.standard.set(value, forKey: taxKey)
            return value
        }
        return tax
    }
    
    func setIOF(with iof: String) {
        UserDefaults.standard.set(iof, forKey: iofKey)
    }
    
    func setPrice(with tax: String) {
        UserDefaults.standard.set(tax, forKey: taxKey)
    }
    
    @objc func registerPrice(sender: UIButton) {
        let alert = UIAlertController(title: "Adicionar Estado", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(UIAlertAction(title: "Adicionar", style: .default, handler: { action in
            self.registerModel(with: alert)
        }))
        
        alert.addTextField { tf in
            tf.placeholder = "Nome do estado"
        }
        
        alert.addTextField { tf in
            tf.placeholder = "Imposto"
            tf.keyboardType = .decimalPad
        }
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func registerModel(with alert: UIAlertController) {
        if let tfs = alert.textFields,
           let tfState = tfs.first,
           let stateName = tfState.text,
           let tfTax = tfs.last,
           let taxValue = tfTax.text {
            if taxValue != "", stateName != ""{
                let model = State(name: stateName, tax: taxValue.replacingOccurrences(of: ",", with: "."))
                CDConfig.shared.saveItem(with: model)
                self.setTableItems()
            }  else {
                self.showErrorAlert()
            }
        }
    }
    
    fileprivate func showErrorAlert() {
        let erroAlert = UIAlertController(title: "Ops", message: "Os campos (Nome do estado e Imposto ) sao obrigatorios", preferredStyle: .alert)
        erroAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.registerPrice(sender: UIButton())
        }))
        self.navigationController?.present(erroAlert, animated: true, completion: nil)
    }
}

//
//  AdjustView.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

final class AdjustView: BaseView, UITextFieldDelegate {
    
    weak var delegate: AdjustSetDelegate?
    
    let iof_tag = 1
    let price_tag = 2
    
    let stackMain: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 15.0
        return view
    }()
    
    let containerPrice: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 5.0
        return view
    }()
    
    let priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Cotação do dolar (R$):"
        return view
    }()
    
    let priceInputText: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.keyboardType = .numberPad
        view.tag = 2
        return view
    }()
    
    let containerIOF: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 5.0
        return view
    }()
    
    let iofLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "IOF (%):"
        view.textAlignment = .right
        return view
    }()
    
    let iofInputText: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.keyboardType = .decimalPad
        view.tag = 1
        return view
    }()
    
    let taxLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Imposto por estado"
        view.textAlignment = .center
        view.font =  UIFont.boldSystemFont(ofSize: 20.0)
        return view
    }()
    
    let containerTaxList: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    let emptyView: EmptyListView = {
        let view = EmptyListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.estimatedRowHeight = 25
        view.backgroundColor = .white
        return view
    }()
    
    let registerPriceButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Adicionar estado", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.titleLabel?.textColor = .blue
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    init(delegate: UITableViewDelegate,
         dataSource: UITableViewDataSource,
         setDelegate: AdjustSetDelegate,
         iof: String,
         price: String,
         tableIsEmpty: Bool) {
        super.init(frame: CGRect())
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
        self.iofInputText.delegate = self
        self.iofInputText.text = iof
        self.priceInputText.delegate = self
        self.priceInputText.text = price
        self.delegate = setDelegate
        self.updateView(tableIsEmpty: tableIsEmpty)
        self.tableView.register(StateCell.self, forCellReuseIdentifier: "Cell")

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func setAddViews() {
        containerPrice.addArrangedSubview(priceLabel)
        containerPrice.addArrangedSubview(priceInputText)
        
        containerIOF.addArrangedSubview(iofLabel)
        containerIOF.addArrangedSubview(iofInputText)
        
        stackMain.addArrangedSubview(containerPrice)
        stackMain.addArrangedSubview(containerIOF)
        stackMain.addArrangedSubview(taxLabel)
        
        let tt = UIView()
        tt.backgroundColor = .cyan
        containerTaxList.addArrangedSubview(tt)
        
        stackMain.addArrangedSubview(containerTaxList)
        stackMain.addArrangedSubview(registerPriceButton)
        
        self.addSubview(stackMain)
    }
        
    internal override func setConstraints() {
        NSLayoutConstraint.activate([
            stackMain.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackMain.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            stackMain.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 15.0),
            stackMain.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -15.0),
            containerPrice.heightAnchor.constraint(equalToConstant: 30.0),
            containerIOF.heightAnchor.constraint(equalToConstant: 30.0),
            taxLabel.heightAnchor.constraint(equalToConstant: 30.0),
            registerPriceButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == iof_tag {
            guard let text = textField.text else { return }
            setUpIOF(with: text)
        } else {
            guard let text = textField.text else { return }
            setUpPrice(with: text)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            textField.text = text
        }
    }
    
    func setUpIOF(with text: String) {
        delegate?.setIOF(with: text)
    }
    
    func setUpPrice(with text: String) {
        delegate?.setPrice(with: text)
    }
    
    func updateView(tableIsEmpty: Bool) {
        let newView = tableIsEmpty == true ? emptyView : tableView
        if let oldView = containerTaxList.arrangedSubviews.first {
            containerTaxList.removeArrangedSubview(oldView)
        }
        containerTaxList.addArrangedSubview(newView)
    }
}

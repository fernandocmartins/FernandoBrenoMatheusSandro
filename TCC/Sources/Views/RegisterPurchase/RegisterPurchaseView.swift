//
//  RegisterPurchaseView.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

final class RegisterPurchaseView: BaseView {
    
    var imagePicker = UIImagePickerController()
    
    var stateData: StateData? {
        didSet {
            self.statePurchaseImputText.text = stateData?.name
        }
    }
    
    var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackMain: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = 15.0
        return view
    }()
    
    let purchaseImageButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "image_default"), for: .normal)
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let productNameImputText: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Nome do produto"
        view.borderStyle = .roundedRect
        return view
    }()
    
    let addState: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        return view
    }()
    
    let checkCard: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = false
        return view
    }()
    
    let card: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Cartao ?"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15.0)
        return view
    }()
    
    let statePurchaseImputText: UITextField = {
        let view = UITextField()
        view.tag = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Estado da compra"
        view.borderStyle = .roundedRect
        return view
    }()
    
    let valueImputText: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Valor da compra"
        view.tag = 2
        view.borderStyle = .roundedRect
        return view
    }()
    
    let registerPurchaseButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("CADASTRAR", for: .normal)
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let containerState: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 5.0
        return view
    }()
    
    let containerCard: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 5.0
        return view
    }()
    
    internal override func setAddViews() {
        containerState.addArrangedSubview(statePurchaseImputText)
        containerState.addArrangedSubview(addState)
        
        containerCard.addArrangedSubview(valueImputText)
        containerCard.addArrangedSubview(card)
        containerCard.addArrangedSubview(checkCard)
        
        stackMain.addArrangedSubview(productNameImputText)
        stackMain.addArrangedSubview(purchaseImageButton)
        stackMain.addArrangedSubview(containerState)
        stackMain.addArrangedSubview(containerCard)
        stackMain.addArrangedSubview(registerPurchaseButton)
        
        self.addSubview(stackMain)
    }
        
    internal override func setConstraints() {
        NSLayoutConstraint.activate([
            stackMain.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackMain.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            stackMain.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 15.0),
            purchaseImageButton.heightAnchor.constraint(equalToConstant: 300.0),
            registerPurchaseButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    func getPurchase() -> Product? {
        guard let name = productNameImputText.text,
            let imageView = purchaseImageButton.imageView,
              let image = imageView.image,
              let price = valueImputText.text,
              let state = stateData else {
            return nil
        }
        if (image == UIImage(named: "image_default")) {
            return nil
        }
        let model = Product(name: name, image: image, state: state, price: price, card: checkCard.isOn)
        return model
    }
    
    func showPickerView() {
        pickerView.isHidden = !pickerView.isHidden
    }
    
    func setupEdit(with data: ProductData?) {
        guard let purchase = data,
        let photo = purchase.photo else { return }
        productNameImputText.text = purchase.name
        purchaseImageButton.setImage(UIImage(data: photo), for: .normal)
        valueImputText.text = purchase.price
        stateData = purchase.state
        checkCard.isOn = purchase.card
    }
    
}

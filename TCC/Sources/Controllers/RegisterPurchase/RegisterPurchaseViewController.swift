//
//  RegisterPurchaseViewController.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

final class RegisterPurchaseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var mainView: RegisterPurchaseView = {
        let view = RegisterPurchaseView()
        view.addState.addTarget(self, action: #selector(addStateAction), for: .touchUpInside)
        view.purchaseImageButton.addTarget(self, action: #selector(setImage), for: .touchUpInside)
        view.registerPurchaseButton.addTarget(self, action: #selector(registerPurchase), for: .touchUpInside)
        view.statePurchaseImputText.delegate = self
        view.valueImputText.delegate = self
        view.productNameImputText.delegate = self
        view.pickerView.delegate = self
        view.imagePicker.delegate = self
        view.imagePicker.sourceType = .photoLibrary
        view.imagePicker.allowsEditing = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    var data: [StateData] = {
       return []
    }()
    
    var product: ProductData?
    
    init(product: ProductData?) {
        super.init(nibName: nil, bundle: nil)
        if let data = product {
            self.product = data
            self.mainView.setupEdit(with: data)
            self.mainView.registerPurchaseButton.setTitle("Atualizar", for: .normal)
        }
        self.mainView.setupEdit(with: product)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cadastrar Produto"
        self.view = mainView
        let tapGesture = UITapGestureRecognizer(target: self.mainView, action: #selector(UIView.endEditing))
        self.mainView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let items = CDConfig.shared.getAllItems(with: StateData.fetchRequest()), let datas = items as? [StateData] {
            self.data = datas
        }
    }
    
    @objc func addStateAction(sender: UIButton) {
        let viewController = AdjustViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func setImage(sender: UIButton) {
        showShose()
    }
    
    @objc func registerPurchase(sender: UIButton) {
        guard let model = self.mainView.getPurchase() else {
            self.showError()
            return
        }
        if let data = product {
            self.updateItem(with: data, newModel: model)
        } else {
            self.saveItem(with: model)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showPickerView(sender: UIButton) {
        let _ = UIView.endEditing(self.mainView)
        self.mainView.showPickerView()
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainView.purchaseImageButton.setImage(image, for: .normal)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.mainView.imagePicker.sourceType = type
            self.present(self.mainView.imagePicker, animated: true, completion: nil)
        }
    }
    
    private func showShose() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Tirar Foto") {
            alert.addAction(action)
        }
        
        if let action = self.action(for: .savedPhotosAlbum, title: "Galeria de Fotos") {
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Ops, algo deu errado =(", message: "Todos os campos foram preenchidos ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveItem(with model: Product) {
        CDConfig.shared.saveItem(with: model)
    }
    
    private func updateItem(with oldModel: ProductData, newModel: Product) {
        CDConfig.shared.updateItem(with: oldModel, newData: newModel)
    }
}

//
//  RegisterPurchaseViewController+TextField.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 24/02/23.
//
import UIKit

extension RegisterPurchaseViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            if !data.isEmpty {
                self.mainView.pickerView.isHidden = false
                let vc = UIViewController()
                vc.view = self.mainView.pickerView
                self.mainView.pickerView.reloadAllComponents()
                vc.view.backgroundColor = UIColor.init(white: 0.7, alpha: 0.9)
                vc.modalPresentationStyle = .formSheet
                vc.preferredContentSize = .init(width: 500, height: 800)
                self.present(vc, animated: true, completion: nil)
            } else {
                self.addStateAction(sender: UIButton())
            }
            return false
        } else if textField.tag == 2 {
            UIView.animate(withDuration: 0.3) {
                self.view.window?.frame.origin.y -= 150
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.tag == 2 {
            UIView.animate(withDuration: 0.3) {
                self.view.window?.frame.origin.y -= -150
            }
        }
    }
}

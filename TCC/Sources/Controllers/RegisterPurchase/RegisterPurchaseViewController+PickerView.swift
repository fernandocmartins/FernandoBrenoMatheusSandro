//
//  RegisterPurchaseViewController+PickerView.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 24/02/23.
//

import UIKit

extension RegisterPurchaseViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let name = data[row].name
        return name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = data[row]
        self.mainView.stateData = item
        self.dismiss(animated: true, completion: nil)
    }
}

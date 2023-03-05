//
//  BaseView.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

class BaseView: UIView, ViewCodeProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddViews() {}
    func setConstraints() {}
}

//
//  ViewCodeProtocol.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

protocol ViewCodeProtocol {
    func setupView()
    func setAddViews()
    func setConstraints()
    
}

extension ViewCodeProtocol{
    func setupView() {
        setAddViews()
        setConstraints()
    }
}

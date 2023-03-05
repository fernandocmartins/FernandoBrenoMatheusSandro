//
//  EmptyListView.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

final class EmptyListView: BaseView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sua lista está vazia!"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setAddViews() {
        self.addSubview(titleLabel)
    }
    
    internal override func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

//
//  TaxByStateCell.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 17/02/23.
//

import UIKit

final class StateCell: UITableViewCell {
    private let name: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 25)
        return view
    }()
    
    private let tax: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 25)
        view.textColor = .red
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(name)
        contentView.addSubview(tax)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            name.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            name.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            tax.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            tax.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            tax.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func setCell(with model: StateData) {
        name.text = model.name
        tax.text = model.tax
    }
    
}

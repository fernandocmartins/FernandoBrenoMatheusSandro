//
//  TotalPurchasePriceView.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 24/02/23.
//

import UIKit

class TotalPurchasePriceView: BaseView {
    private let stackMain: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .fill
        view.spacing = 15.0
        return view
    }()
    
    private let totalUSStask: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .fill
        view.spacing = 15.0
        return view
    }()
    
    private let totalBRStask: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .equalCentering
        view.alignment = .center
        view.spacing = 15.0
        return view
    }()
    
    private let totalUSLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "Total em US$:"
        view.font = UIFont.systemFont(ofSize: 20.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalUSValueLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 60.0)
        view.textColor = .red
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalBRLabel: UILabel = {
        let view = UILabel()
        view.text = "Total em R$:"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 20.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalBRValueLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 60.0)
        view.textColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundUSView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundBRView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setAddViews() {
        self.addSubview(stackMain)
        
        self.stackMain.addArrangedSubview(backgroundUSView)
        self.backgroundUSView.addSubview(totalUSStask)
        self.totalUSStask.addArrangedSubview(totalUSLabel)
        self.totalUSStask.addArrangedSubview(totalUSValueLabel)
        
        self.stackMain.addArrangedSubview(backgroundBRView)
        self.backgroundBRView.addSubview(totalBRStask)
        self.totalBRStask.addArrangedSubview(totalBRLabel)
        self.totalBRStask.addArrangedSubview(totalBRValueLabel)
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            stackMain.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackMain.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            stackMain.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            stackMain.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            
            totalUSStask.centerYAnchor.constraint(equalTo: self.backgroundUSView.centerYAnchor),
            totalUSStask.centerXAnchor.constraint(equalTo: self.backgroundUSView.centerXAnchor),
            
            totalBRStask.centerYAnchor.constraint(equalTo: self.backgroundBRView.centerYAnchor),
            totalBRStask.centerXAnchor.constraint(equalTo: self.backgroundBRView.centerXAnchor)
        ])
    }
    
    func setupValues(totalUS: String, totalBR: String) {
        totalUSValueLabel.text = totalUS
        totalBRValueLabel.text = totalBR
    }
}

//
//  ListerCell.swift
//  TCC
//
//  Created by Fernando Cesar Martins on 16/02/23.
//

import UIKit

final class PurchaseCell: UITableViewCell {
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    private let image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
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
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 80.0),
            image.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            image.leftAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leftAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            nameLabel.leftAnchor.constraint(equalTo: image.layoutMarginsGuide.rightAnchor, constant: 15.0),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            priceLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor),
            priceLabel.leftAnchor.constraint(equalTo: image.layoutMarginsGuide.rightAnchor, constant: 15.0)
        ])
    }
    
    func setCell(with product: ProductData) {
        guard let photoData = product.photo, let photo = UIImage(data: photoData) else { return }
        nameLabel.text = product.name
        priceLabel.text = getDolarPrice(with: product.price)
        image.image = photo
    }
    
    private func getDolarPrice(with real: String?) -> String {
        guard let price = Double(real ?? String()), let dolar_s = UserDefaults.standard.object(forKey: "tax_value") as? String, let dolar = Double(dolar_s) else { return "00.00" }
        let result = price * dolar
        return "\(result.formatted(.currency(code: "BRL")))"
    }
}

//
//  PirateShipCollectionViewCell.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import UIKit

class PirateShipCollectionViewCell: UICollectionViewCell {
  lazy var imageView: UIImageView = {
    let uiimageView = UIImageView(frame: .zero).withAutoLayout()
    uiimageView.contentMode = .scaleAspectFit
    uiimageView.backgroundColor = .blue
    return uiimageView
  }()
  
  lazy var titleLabel: UILabel = {
    let uiLabel = UILabel(frame: .zero).withAutoLayout()
    uiLabel.text = "Title"
    return uiLabel
  }()
  
  lazy var priceLabel: UILabel = {
    let uiLabel = UILabel(frame: .zero).withAutoLayout()
    uiLabel.text = "Price"
    return uiLabel
  }()
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: CGRect.zero)
    
    self.contentView.addSubview(imageView)
    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(priceLabel)
    
    setupContentView()
    setupImageView()
    setupTitleLabel()
    setupPriceLabel()
  }
  
  private func setupContentView() {
    self.contentView.backgroundColor = .darkGray
    self.contentView.layer.cornerRadius = 5
    self.contentView.layer.borderColor = UIColor.black.cgColor
    self.contentView.layer.borderWidth = 1
  }
  
  private func setupImageView() {
    let imageViewConstraints = [
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ]
    NSLayoutConstraint.activate(imageViewConstraints)
  }
  
  private func setupTitleLabel() {
    let titleLabelConstraints = [
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5)
    ]
    NSLayoutConstraint.activate(titleLabelConstraints)
  }
  
  private func setupPriceLabel() {
    let priceLabelConstraints = [
      priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
    ]
    NSLayoutConstraint.activate(priceLabelConstraints)
  }
  
}

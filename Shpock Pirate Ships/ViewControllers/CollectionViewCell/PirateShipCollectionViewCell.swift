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
    uiimageView.image = UIImage(named: "no_image")
    return uiimageView
  }()
  
  lazy var titleLabel: UILabel = {
    let uiLabel = UILabel(frame: .zero).withAutoLayout()
    uiLabel.font = uiLabel.font.withSize(15)
    uiLabel.lineBreakMode = .byWordWrapping
    uiLabel.numberOfLines = 0
    return uiLabel
  }()
  
  lazy var priceLabel: UILabel = {
    let uiLabel = UILabel(frame: .zero).withAutoLayout()
    uiLabel.text = "No Price Available"
    uiLabel.font = uiLabel.font.withSize(15)
    return uiLabel
  }()
  
  var viewModel: CollectionCellViewModel
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    self.viewModel = CollectionCellViewModel()
    
    super.init(frame: CGRect.zero)
    self.contentView.addSubview(imageView)
    self.contentView.addSubview(titleLabel)
    self.contentView.addSubview(priceLabel)
    
    setupContentView()
    setupImageView()
    setupTitleLabel()
    setupPriceLabel()
    bindViewModel()
  }
  
  private func bindViewModel() {
    viewModel.ship.bind { [weak self] ship in
      guard let self = self, let ship = ship else { return }
      self.titleLabel.text = ship.title ?? "No Title Available"
      self.priceLabel.text = "$\(ship.price ?? 0)"
    }
    
    viewModel.imageData.bind { [weak self] data in
      guard let self = self else { return }
      if let imageData = data,
        let uiimage = UIImage(data: imageData) {
        self.imageView.image = uiimage
      } else {
        self.imageView.image = UIImage(named: "no_image")
      }
    }
  }
}

extension PirateShipCollectionViewCell {
  
  private func setupContentView() {
    self.contentView.layer.cornerRadius = 5
    self.contentView.layer.borderColor = UIColor.black.cgColor
    self.contentView.layer.borderWidth = 1
  }
  
  private func setupImageView() {
    let imageViewConstraints = [
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
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
      priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ]
    NSLayoutConstraint.activate(priceLabelConstraints)
  }
  
}

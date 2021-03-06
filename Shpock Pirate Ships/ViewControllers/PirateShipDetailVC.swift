//
//  PirateShipDetailVC.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import UIKit

class PirateShipDetailVC: UIViewController {
  lazy var imageView: UIImageView = {
    let uiimageView = UIImageView(frame: .zero).withAutoLayout()
    uiimageView.contentMode = .scaleAspectFit
    uiimageView.image = UIImage(named: "no_image")
    return uiimageView
  }()
  
  lazy var titleLabel: UILabel = {
    let uiLabel = UILabel(frame: .zero).withAutoLayout()
    uiLabel.font = uiLabel.font.withSize(24)
    uiLabel.lineBreakMode = .byWordWrapping
    uiLabel.numberOfLines = 0
    return uiLabel
  }()
  
  lazy var descriptionLabel: UILabel = {
    let uiLabel = UILabel(frame: .zero).withAutoLayout()
    uiLabel.font = uiLabel.font.withSize(15)
    uiLabel.lineBreakMode = .byWordWrapping
    uiLabel.numberOfLines = 0
    return uiLabel
  }()
  
  lazy var priceLabel: UILabel = {
    let uiLabel = UILabel(frame: .zero).withAutoLayout()
    uiLabel.text = "No Price Available"
    uiLabel.font = uiLabel.font.withSize(18)
    return uiLabel
  }()
  
  lazy var greetingButton: UIButton = {
    let uiButton = UIButton(frame: .zero).withAutoLayout()
    uiButton.layer.cornerRadius = 5
    uiButton.backgroundColor = .systemBlue
    uiButton.setTitle("Say Hi!", for: .normal)
    return uiButton
  }()
  
  let viewModel: PirateShipDetailViewModel
  
  init(viewModel: PirateShipDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(imageView)
    self.view.addSubview(titleLabel)
    self.view.addSubview(descriptionLabel)
    self.view.addSubview(priceLabel)
    self.view.addSubview(greetingButton)
    
    setupImageView()
    setupTitleLabel()
    setupDescriptionLabel()
    setupPriceLabel()
    setupGreetingButton()
    bindViewModel()
  }
  
  private func bindViewModel() {
    viewModel.model.bind { pirateShip in
      self.titleLabel.text = pirateShip.getTitle()
      self.descriptionLabel.text = pirateShip.description
      self.priceLabel.text = pirateShip.getPrice()
    }
    
    viewModel.imageData.bind { data in
      if let imageData = data,
        let uiimage = UIImage(data: imageData) {
        self.imageView.image = uiimage
      }
    }
    
    viewModel.greeting.bind { pirateGreeting in
      if pirateGreeting.isEmpty { return }
      self.showAlert(greeting: pirateGreeting)
    }
  }
}

extension PirateShipDetailVC {
  private func setupImageView() {
    let imageViewConstraints = [
      imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
      imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
    ]
    NSLayoutConstraint.activate(imageViewConstraints)
  }
  
  private func setupTitleLabel() {
    let titleLabelConstraints = [
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
    ]
    NSLayoutConstraint.activate(titleLabelConstraints)
  }
  
  private func setupDescriptionLabel() {
    let descriptionLabelConstraints = [
      descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25)
    ]
    NSLayoutConstraint.activate(descriptionLabelConstraints)
  }
  
  private func setupPriceLabel() {
    let priceLabelConstraints = [
      priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
      priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: greetingButton.topAnchor, constant: 30)
    ]
    NSLayoutConstraint.activate(priceLabelConstraints)
  }
  
  private func setupGreetingButton() {
    let buttonConstraints = [
      greetingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      greetingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      greetingButton.heightAnchor.constraint(equalToConstant: 50),
      greetingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
    ]
    NSLayoutConstraint.activate(buttonConstraints)
    
    greetingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
  }
  
  @IBAction func didTapButton() {
    viewModel.didTapButton()
  }
  
  private func showAlert(greeting: String) {
    let alert = UIAlertController(title: nil, message: greeting, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    self.present(alert, animated: true, completion: nil)
  }
}

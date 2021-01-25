//
//  PirateShipCollectionVC.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 23/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import UIKit

class PirateShipCollectionVC: UIViewController, UICollectionViewDelegate {
  private let cellIdentifier = "collectionCell"
  lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    let collView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout).withAutoLayout()
    collView.showsVerticalScrollIndicator = false
    collView.backgroundColor = .white
    collView.delegate = self
    collView.dataSource = self
    return collView
  }()
  
  let viewModel: PirateShipViewModel = PirateShipViewModelImp()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(collectionView)
    setupNavigationBar()
    setupCollectionView()
    bindViewModel()
  }
  
  private func bindViewModel() {
    viewModel.setup()
    viewModel.models.bind { ships in
      self.updateCollectionView()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let models = viewModel.models.value else { return }
    
    let selectedShip = models[indexPath.row]
    let imageData = viewModel.cache[selectedShip.id]
    let detailVC = viewModel.goToDetail(ship: selectedShip, imageData: imageData)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}

extension PirateShipCollectionVC {
  private func updateCollectionView() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  private func setupNavigationBar() {
    self.navigationItem.title = "Pirate Ships"
  }
  
  private func setupCollectionView() {
    collectionView.register(PirateShipCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    
    let constraints = [
      collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
    ]
    NSLayoutConstraint.activate(constraints)
  }
}

extension PirateShipCollectionVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let models = viewModel.models.value else { return 0 }
    return models.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                  for: indexPath as IndexPath) as! PirateShipCollectionViewCell
    guard let models = viewModel.models.value else { return cell }
    
    let currentShip = models[indexPath.row]
    if let data = viewModel.cache[currentShip.id] {
      cell.viewModel.imageData.value = data
    } else {
      downloadAndSetCellImage(cell: cell, ship: currentShip)
    }
    cell.viewModel.ship.value = currentShip
    return cell
  }
  
  private func downloadAndSetCellImage(cell: PirateShipCollectionViewCell, ship: PirateShip) {
    guard let imageUrl = ship.image else { return }
    viewModel.getImage(shipID: ship.id, url: imageUrl) { data in
      DispatchQueue.main.async {
        cell.viewModel.imageData.value = data
      }
    }
  }
}

extension PirateShipCollectionVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.width - 20) / 2, height: (collectionView.frame.height - 30) / 2.5)
  }
}



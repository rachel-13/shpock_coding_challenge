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
  var collectionView: UICollectionView!
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setupNavigationBar()
    setupCollectionView()
  }
  
  private func setupNavigationBar() {
    self.navigationItem.title = "Pirate Ships"
  }
  
  private func setupCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout).withAutoLayout()
    collectionView.backgroundColor = .white
    collectionView.delegate = self
    collectionView.dataSource = self
    self.view.addSubview(collectionView)
    
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
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                  for: indexPath as IndexPath) as! PirateShipCollectionViewCell
  
    return cell
  }
}

extension PirateShipCollectionVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.width - 20) / 2, height: (collectionView.frame.height - 30) / 3.2)
  }
}



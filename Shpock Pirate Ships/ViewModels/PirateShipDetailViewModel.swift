//
//  PirateShipDetailViewModel.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

protocol PirateShipDetailViewModel {
  var model: PirateShip { get }
  var imageData: Data? { get }
}

class PirateShipDetailViewModelImp: PirateShipDetailViewModel {
  
  var model: PirateShip
  var imageData: Data?
  
  init(model: PirateShip, imageData: Data?) {
    self.model = model
    self.imageData = imageData
  }
}




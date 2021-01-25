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
  func buttonTapped()
}

class PirateShipDetailViewModelImp: PirateShipDetailViewModel {
  
  var model: PirateShip
  
  init(model: PirateShip) {
    self.model = model
  }
  
  func buttonTapped() {
    
  }
}




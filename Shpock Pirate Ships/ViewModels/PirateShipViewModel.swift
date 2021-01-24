//
//  PirateShipViewModel.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

protocol PirateShipViewModel {
  func displayShips(ships: [PirateShip])
  func fetchPirateShips()
}

class PirateShipViewModelImp: PirateShipViewModel {
  var model: [PirateShip]
  
  init(model: [PirateShip]) {
    self.model = model
  }
  
  func displayShips(ships: [PirateShip]) {
    
  }
  
  func fetchPirateShips() {
    
  }
}

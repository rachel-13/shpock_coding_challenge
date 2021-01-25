//
//  CollectionCellViewModel.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

class CollectionCellViewModel {
  var ship: Observable<PirateShip?>
  var imageData: Observable<Data?>
  
  init() {
    self.ship = Observable<PirateShip?>(nil)
    self.imageData = Observable<Data?>(nil)
  }
}

//
//  PirateShipDetailViewModel.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

protocol PirateShipDetailViewModel {
  var model: Observable<PirateShip> { get }
  var imageData: Observable<Data?> { get }
  var greeting: Observable<String> { get }
  func didTapButton()
}

class PirateShipDetailViewModelImp: PirateShipDetailViewModel {
  
  var model: Observable<PirateShip>
  var imageData: Observable<Data?>
  var greeting: Observable<String>
  
  init(model: PirateShip, imageData: Data?) {
    self.model = Observable(model)
    self.imageData = Observable(imageData)
    self.greeting = Observable("")
  }
  
  func didTapButton() {
    let pirateGreet = self.model.value.getGreeting()
    self.greeting.value = pirateGreet
  }
}




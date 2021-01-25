//
//  PirateShipViewModel.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

protocol PirateShipViewModel {
  var models: [PirateShip] { get }
  var cache: [Int: Data] { get }
  func fetchPirateShips(completionHandler: @escaping (Bool, APIError?) -> Void)
  func getImage(shipID: Int, url: String, completionHandler: @escaping (Data?) -> Void)
  func goToDetail()
}

class PirateShipViewModelImp: PirateShipViewModel {
  var models: [PirateShip]
  let api: PirateShipAPI
  var cache: [Int : Data]
  
  init(model: [PirateShip], api: PirateShipAPI = PirateShipAPIImp()) {
    self.models = model
    self.api = api
    self.cache = [Int: Data]()
  }
  
  func fetchPirateShips(completionHandler: @escaping (Bool, APIError?) -> Void) {
    api.getPirateShip { [weak self] response in
      guard let self = self else { return }
      switch response {
        case .success(let apiResponse):
          if apiResponse.success {
            self.models = apiResponse.ships
            completionHandler(true, nil)
          } else {
            completionHandler(false, APIError.unknownError)
        }
        case .failure(let error):
          completionHandler(false, error)
      }
    }
  }
  
  func getImage(shipID: Int, url: String, completionHandler: @escaping (Data?) -> Void) {
    api.getImage(url: url) { [weak self] response in
      guard let self = self else { return }
      switch response {
        case .success(let data):
          self.cache[shipID] = data
          completionHandler(data)
        case .failure(_):
          completionHandler(nil)
      }
    }
  }
  
  func goToDetail() {
    
  }
}

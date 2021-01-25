//
//  PirateShipViewModel.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

protocol PirateShipViewModel {
  var models: Observable<[PirateShip]?> { get }
  var cache: [Int: Data] { get }
  func setup()
//  func fetchPirateShips(completionHandler: @escaping (Bool, APIError?) -> Void)
  func getImage(shipID: Int, url: String, completionHandler: @escaping (Data?) -> Void)
  func goToDetail(ship: PirateShip, imageData: Data?) -> PirateShipDetailVC
}

class PirateShipViewModelImp: PirateShipViewModel {
  var models: Observable<[PirateShip]?>
  let api: PirateShipAPI
  var cache: [Int : Data]
  
  init(api: PirateShipAPI = PirateShipAPIImp()) {
    self.models = Observable<[PirateShip]?>(nil)
    self.api = api
    self.cache = [Int: Data]()
  }
  
  func setup() {
    api.getPirateShip { [weak self] response in
      guard let self = self else { return }
      switch response {
        case .success(let apiResponse):
          if apiResponse.success {
            self.models.value = apiResponse.ships
//            completionHandler(true, nil)
          } else {
//            completionHandler(false, APIError.unknownError)
        }
        case .failure(let error): break
//          completionHandler(false, error)
      }
    }
  }
  
  func fetchPirateShips(completionHandler: @escaping (Bool, APIError?) -> Void) {
    
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
  
  func goToDetail(ship: PirateShip, imageData: Data?) -> PirateShipDetailVC {
    let detailViewModel = PirateShipDetailViewModelImp(model: ship, imageData: imageData)
    let detailVC = PirateShipDetailVC(viewModel: detailViewModel)
    return detailVC
  }
}

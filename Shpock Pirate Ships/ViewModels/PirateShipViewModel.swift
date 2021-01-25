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
  var errorMessage: Observable<String?> { get }
  func setup()
  func getImage(shipID: Int, url: String, completionHandler: @escaping (Data?) -> Void)
  func goToDetail(ship: PirateShip, imageData: Data?) -> PirateShipDetailVC
}

class PirateShipViewModelImp: PirateShipViewModel {
  var models: Observable<[PirateShip]?>
  let api: PirateShipAPI
  var cache: [Int : Data]
  var errorMessage: Observable<String?>
  
  init(api: PirateShipAPI = PirateShipAPIImp()) {
    self.models = Observable<[PirateShip]?>(nil)
    self.api = api
    self.cache = [Int: Data]()
    self.errorMessage = Observable<String?>(nil)
  }
  
  func setup() {
    api.getPirateShip { [weak self] response in
      guard let self = self else { return }
      switch response {
        case .success(let apiResponse):
          if apiResponse.success {
            self.models.value = apiResponse.ships
        }
        case .failure(let error):
          switch error {
            case .invalidURL:
              self.errorMessage.value = "URL not valid"
            case .parsingError:
              self.errorMessage.value = "Parsing response error"
            default:
              self.errorMessage.value = "Unknown Error"
          }
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
  
  func goToDetail(ship: PirateShip, imageData: Data?) -> PirateShipDetailVC {
    let detailViewModel = PirateShipDetailViewModelImp(model: ship, imageData: imageData)
    let detailVC = PirateShipDetailVC(viewModel: detailViewModel)
    return detailVC
  }
}

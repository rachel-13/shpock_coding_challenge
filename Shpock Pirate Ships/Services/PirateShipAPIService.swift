//
//  PirateShipAPI.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

protocol PirateShipAPI {
  func getPirateShip(completion: @escaping (Result<GetPirateShipsResponse, APIError>) -> Void)
  func getImage(url: String, completion: @escaping APICompletionHandler)
}

class PirateShipAPIImp: PirateShipAPI {
  let baseUrl = "https://assets.shpock.com/"
  let getPirateShipsPath = "mobile/interview-test/pirateships"
  
  let serviceManager: ServiceManager
  
  init(serviceManager: ServiceManager = ServiceManagerImp.shared) {
    self.serviceManager = serviceManager
  }
  
  func getPirateShip(completion: @escaping (Result<GetPirateShipsResponse, APIError>) -> Void) {
    serviceManager.get(url: "\(baseUrl)\(getPirateShipsPath)") { response in
      switch response {
        case .success(let data):
          do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
              let apiResponse = GetPirateShipsResponse(jsonObject: json)
              completion(.success(apiResponse))
            } else {
              completion(.failure(.parsingError))
            }
          } catch {
            completion(.failure(.parsingError))
        }
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  func getImage(url: String, completion: @escaping APICompletionHandler) {
    serviceManager.get(url: url) { response in
      switch response {
        case .success(let data):
          completion(.success(data))
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
}


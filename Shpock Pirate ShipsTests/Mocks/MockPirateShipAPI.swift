//
//  MockPirateShipAPI.swift
//  Shpock Pirate ShipsTests
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation
@testable import Shpock_Pirate_Ships

class MockPirateShipAPI: PirateShipAPI {
  
  var shouldAPISucceed = true
  var stubbedResponse = GetPirateShipsResponse(jsonObject: [String : Any]())
  var stubbedAPIError = APIError.unknownError
  func getPirateShip(completion: @escaping (Result<GetPirateShipsResponse, APIError>) -> Void) {
    if shouldAPISucceed {
      completion(.success(stubbedResponse))
    } else {
      completion(.failure(stubbedAPIError))
    }
  }
  
  var shouldImageDownloadSucceed = true
  var stubbedImageData = Data()
  func getImage(url: String, completion: @escaping APICompletionHandler) {
    if shouldImageDownloadSucceed {
      completion(.success(stubbedImageData))
    } else {
      completion(.failure(APIError.unknownError))
    }
  }
}

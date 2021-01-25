//
//  MockServiceManager.swift
//  Shpock Pirate ShipsTests
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation
@testable import Shpock_Pirate_Ships

class MockServiceManager: ServiceManager {
  var stubbedData: Data?
  var stubbedError = APIError.unknownError
  var shouldServiceManagerAPISucceed = true
  func get(url: String, completion: @escaping APICompletionHandler) {
    if shouldServiceManagerAPISucceed, let stubbedData = stubbedData {
      completion(.success(stubbedData))
    } else {
      completion(.failure(stubbedError))
    }
  }
}

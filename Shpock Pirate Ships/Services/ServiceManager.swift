//
//  ServiceManager.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

typealias APICompletionHandler = (Result<Data, APIError>) -> Void

enum APIError: Error {
  case invalidURL
  case clientError
  case serverError
  case parsingError
  case unknownError
}

protocol ServiceManager {
  func get(url: String, completion: @escaping APICompletionHandler)
}

class ServiceManagerImp: ServiceManager {
  static let shared = ServiceManagerImp()
  
  private init() { }
  
  func get(url: String, completion: @escaping APICompletionHandler) {
    guard let url = URL(string: url) else {
      completion(.failure(APIError.invalidURL))
      return
    }
    
    let request = URLRequest(url: url)
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
      if let data = data {
        completion(.success(data))
      } else {
        completion(.failure(APIError.unknownError))
      }
    }
    
    task.resume()
  }
}

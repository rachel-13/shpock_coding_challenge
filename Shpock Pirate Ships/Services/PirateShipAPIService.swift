//
//  PirateShipAPI.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

typealias GetPirateShipsCompletionHandler = (Result<[PirateShip], Error>) -> Void
typealias GetPirateShipsImageCompletionHandler = (Result<Data, Error>) -> Void

protocol PirateShipAPI {
  func getPirateShip(completion: @escaping GetPirateShipsCompletionHandler)
  func getImage(url: String, completion: @escaping GetPirateShipsImageCompletionHandler)
}




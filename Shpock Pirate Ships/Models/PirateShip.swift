//
//  PirateShip.swift
//  Shpock Pirate Ships
//
//  Created by pohyee on 24/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import Foundation

struct PirateShip: Codable {
  let id: Int
  let title: String?
  let description: String?
  let price: Int?
  let image: String?
  let greetingType: String?
  let imageData: Data?
  
  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case price = "price"
    case description = "description"
    case image = "image"
    case greetingType = "greeting_type"
    case imageData = "imageData" 
  }
  
  func getGreeting() -> String {
    guard let greetingType = self.greetingType else {
      return "Ahoi!"
    }
    switch greetingType {
      case "ah":
        return "Ahoi!"
      case "ay":
        return "Aye Aye!"
      case "ar":
        return "Arrr!"
      case "yo":
        return "Yo ho hooo!"
      default:
        return "Ahoi!"
    }
  }
}

struct GetPirateShipsResponse {
  let success: Bool
  var ships: [PirateShip]
  let decoder = JSONDecoder()
  
  private enum CodingKeys: String, CodingKey {
    case success = "success"
    case ships = "ships"
  }
  
  init(jsonObject: [String: Any]) {
    success = (jsonObject[CodingKeys.success.rawValue] != nil)
    ships = [PirateShip]()
    
    if let arrayOfShips = jsonObject[CodingKeys.ships.rawValue] as? [Any] {
      for element in arrayOfShips {
        if !(element is NSNull) {
          parseElementAndAddToShip(element: element)
        }
      }
    }
  }
  
  private mutating func parseElementAndAddToShip(element: Any) {
    do {
      let elementData = try JSONSerialization.data(withJSONObject: element, options: .fragmentsAllowed)
      let ship = try decoder.decode(PirateShip.self, from: elementData)
      ships.append(ship)
    } catch {
      print(error)
    }
  }
}

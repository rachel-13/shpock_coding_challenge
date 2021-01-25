//
//  PirateShipCellViewModelTests.swift
//  Shpock Pirate ShipsTests
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import XCTest
@testable import Shpock_Pirate_Ships

class PirateShipCellViewModelTests: XCTestCase {
  var sut: CollectionCellViewModel!
  
  override func setUpWithError() throws {
    sut = CollectionCellViewModel()
  }
  
  func test_init_set_ship() {
    let mockPirateShip = PirateShip(id: 1,
                                    title: "title1",
                                    description: nil,
                                    price: 10,
                                    image: nil,
                                    greetingType: "ar")
    sut.ship.value = mockPirateShip
    XCTAssertEqual(sut.ship.value?.greetingType, mockPirateShip.greetingType)
  }
  
}

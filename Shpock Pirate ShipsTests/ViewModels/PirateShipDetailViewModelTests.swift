//
//  PirateShipDetailViewModelTests.swift
//  Shpock Pirate ShipsTests
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import XCTest
@testable import Shpock_Pirate_Ships

class PirateShipDetailViewModelTests: XCTestCase {
  
  var sut: PirateShipDetailViewModelImp!
  
  func test_didTapButtonWith_ar() {
    let mockPirateShip_ar = PirateShip(id: 1,
                                       title: "title1",
                                       description: nil,
                                       price: 10,
                                       image: nil,
                                       greetingType: "ar")
    sut = PirateShipDetailViewModelImp(model: mockPirateShip_ar, imageData: Data())
    sut.model.value = mockPirateShip_ar
    sut.didTapButton()
    XCTAssertEqual(sut.greeting.value, "Arrr!")
    XCTAssertEqual(sut.model.value.title, mockPirateShip_ar.title)
  }
  
  func test_didTapButtonWith_ah() {
    let mockPirateShip_ah = PirateShip(id: 2,
                                       title: nil,
                                       description: "description2",
                                       price: 20,
                                       image: nil,
                                       greetingType: "ah")
    sut = PirateShipDetailViewModelImp(model: mockPirateShip_ah, imageData: Data())
    sut.model.value = mockPirateShip_ah
    sut.didTapButton()
    XCTAssertEqual(sut.greeting.value, "Ahoi!")
    XCTAssertNil(sut.model.value.title)
    XCTAssertEqual(sut.model.value.description, mockPirateShip_ah.description)
  }
}

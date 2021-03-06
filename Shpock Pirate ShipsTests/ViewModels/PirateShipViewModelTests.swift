//
//  PirateShipViewModelTests.swift
//  Shpock Pirate ShipsTests
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import XCTest
@testable import Shpock_Pirate_Ships

class PirateShipViewModelTests: XCTestCase {
  var mockAPI: MockPirateShipAPI!
  var sut: PirateShipViewModelImp!
  
  override func setUpWithError() throws {
    mockAPI = MockPirateShipAPI()
    sut = PirateShipViewModelImp(api: mockAPI)
  }
  
  func test_getPirateShipsApi_succeeds() {
    let stubbedShip1: [String: Any] = ["id": 1, "title": "title1", "price": 1]
    let stubbedShip2: [String: Any] = ["id": 2, "title": NSNull(), "price": 2]
    let stubbedShip3: [String: Any] = ["id": 3, "title": "title3", "price": 1]
    let stubbedResponseDict: [String: Any] = [
      "success": true,
      "ships": [stubbedShip1, stubbedShip2, stubbedShip3]
    ]
    mockAPI.shouldAPISucceed = true
    mockAPI.stubbedResponse = GetPirateShipsResponse(jsonObject: stubbedResponseDict)
    sut.setup()
    
    XCTAssertEqual(3, sut.models.value?.count)
    
    XCTAssertEqual(1, sut.models.value?[0].id)
    XCTAssertEqual(2, sut.models.value?[1].id)
    XCTAssertEqual(3, sut.models.value?[2].id)
    
    XCTAssertEqual("title1", sut.models.value?[0].title)
    XCTAssertNil(sut.models.value?[1].title)
  }
  
  func test_getPirateShipsApi_failsWith_parsingError() {
    
    mockAPI.shouldAPISucceed = false
    mockAPI.stubbedAPIError = APIError.parsingError
    sut.setup()
    
    XCTAssertEqual(sut.errorMessage.value, "Parsing response error")
    XCTAssertNil(sut.models.value)
  }
  
  func test_getPirateShipsApi_failsWith_invalidUrlError() {
    
    mockAPI.shouldAPISucceed = false
    mockAPI.stubbedAPIError = APIError.invalidURL
    sut.setup()
    
    XCTAssertEqual(sut.errorMessage.value, "URL not valid")
    XCTAssertNil(sut.models.value)
  }
  
  func test_getPirateShipImageDownload_succeeds() {
    mockAPI.shouldImageDownloadSucceed = true
    mockAPI.stubbedImageData = Data()
    sut.getImage(shipID: 1, url: "someurl") { data in
      XCTAssertEqual(1, self.sut.cache.count)
      XCTAssertNotNil(data)
    }
  }
  
  func test_getPirateShipImageDownload_fails() {
    mockAPI.shouldImageDownloadSucceed = false
    sut.getImage(shipID: 1, url: "someurl") { data in
      XCTAssertEqual(0, self.sut.cache.count)
      XCTAssertNil(data)
    }
  }
}

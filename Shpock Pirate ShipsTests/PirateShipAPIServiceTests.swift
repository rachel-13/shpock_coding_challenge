//
//  PirateShipAPIServiceTests.swift
//  Shpock Pirate ShipsTests
//
//  Created by pohyee on 25/01/2021.
//  Copyright © 2021 pohyee. All rights reserved.
//

import XCTest
@testable import Shpock_Pirate_Ships

class PirateShipAPIServiceTests: XCTestCase {
  var sut: PirateShipAPIImp!
  var mockServiceManager: MockServiceManager!
  
  override func setUpWithError() throws {
    mockServiceManager = MockServiceManager()
    sut = PirateShipAPIImp(serviceManager: mockServiceManager)
  }
  
  func test_getPirateShipAPI_succeeds() {
    mockServiceManager.shouldServiceManagerAPISucceed = true
    mockServiceManager.stubbedData = Constants.jsonString.data(using: .utf8) ?? Data()
    sut.getPirateShip { stubbedResponse in
      switch stubbedResponse {
        case .success(let response):
          XCTAssertEqual(response.ships.count, 10)
        case .failure(_):
          XCTFail()
      }
    }
  }
  
  func test_getPirateShipAPI_failsWith_parsingError() {
    mockServiceManager.shouldServiceManagerAPISucceed = true
    mockServiceManager.stubbedData = "randomjsonstring".data(using: .utf8) ?? Data()
    sut.getPirateShip { stubbedResponse in
      switch stubbedResponse {
        case .success(_):
          XCTFail()
        case .failure(let error):
          XCTAssertEqual(error, APIError.parsingError)
      }
    }
  }
  
  func test_getPirateShipImageDownload_succeeds() {
    mockServiceManager.shouldServiceManagerAPISucceed = true
    mockServiceManager.stubbedData = Data()
    sut.getImage(url: "someurl") { stubbedResponse in
      switch stubbedResponse {
        case .success(let response):
          XCTAssertNotNil(response)
        case .failure(_):
          XCTFail()
      }
    }
  }
  
  func test_getPirateShipImageDownload_fails() {
    mockServiceManager.shouldServiceManagerAPISucceed = false
    mockServiceManager.stubbedData = Data()
    sut.getImage(url: "someurl") { stubbedResponse in
      switch stubbedResponse {
        case .success(_):
          XCTFail()
        case .failure(let error):
          XCTAssertEqual(error, APIError.unknownError)
      }
    }
  }
  
  override func tearDownWithError() throws {
    mockServiceManager.stubbedError = .unknownError
    mockServiceManager.stubbedData = nil
  }
}

class Constants {
  static let jsonString = """
            {
          "success": true,
          "ships": [
            {
              "id": 84375012,
              "title": "How misty. You ransack like an ale.",
              "description": "Anchors scream on yellow fever at haiti! How sunny. You haul like a cloud.",
              "price": 34,
              "image": "http://images.bit-tech.net/content_images/2008/01/pirates_of_the_burning_sea/p.jpg",
              "greeting_type": "ah"
            },
            {
              "id": 46347657,
              "title": "C'mon, small halitosis!",
              "description": "Flavum, pius cobaltums patienter locus de festus, neuter axona. Ususs ortum in brema!",
              "price": 249,
              "image": "https://www.fileplanet.com/fileblog/images/PirateFiles/POTBS_1.jpg",
              "greeting_type": "ay"
            },
            {
              "id": 76879554,
              "title": null,
              "description": "Yuck there's nothing like the mighty life hobbling on the scallywag.",
              "price": 12,
              "image": "http://s1.picswalls.com/wallpapers/2014/04/19/sea-pirate-desktop-wallpapers_123209479_36.jpg",
              "greeting_type": "ar"
            },
            null,
            {
              "id": 12244094,
              "title": "Planks sing with booty!",
              "description": "The sail screams booty like a heavy-hearted cockroach. Ho-ho-ho! passion of horror.",
              "price": 899,
              "image": "http://images.bit-tech.net/content_images/2008/01/pirates_of_the_burning_sea/p.jpg",
              "greeting_type": "yo"
            },
            {
              "id": 6769334,
              "title": "Ho-ho-ho! madness of fight.",
              "description": "Desire me corsair, ye weird scabbard! Why does the gull whine? Lively, addled doubloons quirky fight a swashbuckling, gutless wench.",
              "price": 799,
              "image": "https://s-media-cache-ak0.pinimg.com/originals/06/94/e3/0694e3a546c6079939db6b5e15f6514a.jpg"
            },
            {
              "id": 4353442,
              "title": "Grogs hobble from endurances like real breezes.",
              "description": "Ah there's nothing like the clear passion stuttering on the cannon. Big, heavy-hearted suns calmly hoist a clear, swashbuckling wave.",
              "price": 149,
              "image": "https://www.fileplanet.com/fileblog/images/PirateFiles/POTBS_1.jpg"
            },
            {
              "id": 3234977,
              "title": "Where is the evil gold?",
              "description": "Wow, hunger! Arrr, rainy cannibal. go to tortuga. Loot me swabbie, ye swashbuckling rum!",
              "price": 1200,
              "image": "http://images.bit-tech.net/content_images/2008/01/pirates_of_the_burning_sea/p.jpg"
            },
            {
              "id": 7149334,
              "title": "Arrr, golden captain. go to port degas.",
              "description": "Shipmate of a weird grace, command the horror! Damn yer mate, feed the moon.",
              "price": 50,
              "image": "http://s1.picswalls.com/wallpapers/2014/04/19/sea-pirate-desktop-wallpapers_123209479_36.jpg"
            },
            {
              "id": 6912321,
              "title": "Small deaths lead to the yellow fever.",
              "description": "Where is the scrawny mate? Parrots are the sailors of the mighty desolation. Lord, rob me skull, ye mighty pants!",
              "price": 360,
              "image": "https://www.fileplanet.com/fileblog/images/PirateFiles/POTBS_1.jpg",
              "greeting_type": null
            },
            {
              "id": 2279432,
              "title": "The pirate hails with grace, command the seychelles before it waves. Punishment ho! vandalize to be desired.",
              "description": "Aye! Pieces o' amnesty are forever swashbuckling. Desolation ho! scrape to be haulled.",
              "price": 125,
              "image": "http://images.bit-tech.net/content_images/2008/01/pirates_of_the_burning_sea/p.jpg"
            }
          ]
        }
"""
}

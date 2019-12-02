//
//  RoverTests.swift
//  Unit Tests
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import XCTest
@testable import Mars_Explorer

class RoverTests: XCTestCase {
	var jsonData: Data = Data()
	let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-mm-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	private let filename = "rover_sample"
	
	private let roverId = 5
	private let roverName = "Curiosity"
	private let roverLandingDate = Calendar.current.date(from: DateComponents(year: 2012, month: 8, day: 6))!
	private let roverLaunchDate = Calendar.current.date(from: DateComponents(year: 2011, month: 11, day: 26))!
	private let roverStatus = RoverStatus.active
	private let roverMaxSol = 2540
	private let roverMaxDate = Calendar.current.date(from: DateComponents(year: 2019, month: 9, day: 28))!
	private let roverTotalPhotos = 366206
	private let roverCamera1Name = "FHAZ"
	
	override class func setUp() {
		super.setUp()
//		jsonData = dataFromJson(for: filename)
	}
	
	func testDecodable() {
		do {
			let rover = try decoder.decode(Rover.self, from: jsonData)
			XCTAssert(rover.id == roverId, "The Rover.id property was not decoded properly. \(roverId) is the correct value, but the value decoded from the JSON was: \(rover.id)")
			XCTAssert(rover.name == roverName, "The Rover.id property was not decoded properly. \(roverName) is the correct value, but the value decoded from the JSON was: \(rover.name)")
			XCTAssert(rover.landingDate == roverLandingDate, "The Rover.id property was not decoded properly. \(roverLandingDate) is the correct value, but the value decoded from the JSON was: \(rover.landingDate)")
			XCTAssert(rover.launchDate == roverLaunchDate, "The Rover.id property was not decoded properly. \(roverLaunchDate) is the correct value, but the value decoded from the JSON was: \(rover.launchDate)")
		} catch {
//			XCTFail("""
//				\(fileName).json was unable to be parsed by the initializer provided by conforming to the Decodable protocol. Check your implementation before continuing.
//				Error:
//					\(error)
//				""")
		}
	}


}

//
//  PhotoTests.swift
//  Mars ExplorerTests
//
//  Created by Nathan Ansel on 12/6/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import XCTest
@testable import Mars_Explorer

class PhotoTests: XCTestCase {
	
    var jsonData: Data = Data()
	let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-MM-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	private var fileName = "photo_sample"
	private let photoID = 665791
	private let photoSol = 2224
	private let photoImgSrc = "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02224/opgs/edr/fcam/FRA_594936755EDR_F0730550FHAZ00337M_.JPG"
	private let photoEarthDate = Calendar.current.date(from: DateComponents(year: 2018, month: 11, day: 8))!
	private let cameraName = "FHAZ"
	private let roverName = "Curiosity"
	
    override func setUp() {
		super.setUp()
		jsonData = dataFromJson(for: fileName)
    }
	
	func testPhotoDecodable() {
		do {
			let photo = try decoder.decode(Photo.self, from: jsonData)
			XCTAssert(photo.id == photoID, "The Photo.id property was not decoded properly. \(photoID) is the correct value, but the value decoded from the JSON was: \(photo.id)")
			XCTAssert(photo.sol == photoSol, "The Photo.sol property was not decoded properly. \(photoSol) is the correct value, but the value decoded from the JSON was: \(photo.sol)")
			XCTAssert(photo.imgSrc == photoImgSrc, "The Photo.imgSrc property was not decoded properly. \(photoImgSrc) is the correct value, but the value decoded from the JSON was: \(photo.imgSrc)")
			XCTAssert(photo.earthDate == photoEarthDate, "The Photo.earthDate property was not decoded properly. \(photoEarthDate) is the correct value, but the value decoded from the JSON was: \(photo.earthDate)")
			XCTAssert(photo.camera.name == cameraName, "The Photo.cameras property was not decoded properly. \(cameraName) is the correct value of the camera's name, but the value decoded from the JSON was: \(photo.camera.name)")
			XCTAssert(photo.rover.name == roverName, "The Photo.rover property was not decoded properly. \(roverName) is the correct value of the rover's name, but the value decoded from the JSON was: \(photo.rover.name)")
		} catch {
			XCTFail("""
				\(fileName).json was unable to be parsed by the initializer provided by conforming to the Decodable protocol. Check your implementation before continuing.
				Error:
					\(error)
				""")
		}
	}

	func testNewPhotoDecodable() throws {
		jsonData = dataFromJson(for: "photo_sample_2")
		let photo = try decoder.decode(Photo.self, from: jsonData)
		XCTAssertEqual(photo.id, 1154316)
		XCTAssertEqual(photo.sol, 3872)
		XCTAssertEqual(photo.rover.id, 5)
		XCTAssertEqual(photo.rover.name, "Curiosity")
		XCTAssertNil(photo.rover.maxSol)
	}
}

//
//  PhotoSetTests.swift
//  Mars ExplorerTests
//
//  Created by Nathan Ansel on 12/6/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import XCTest
@testable import Mars_Explorer

class PhotoSetTests: XCTestCase {
	
	var jsonData: Data = Data()
	let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-MM-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	private var fileName = "photo_set_sample"
	private let setSol = 2377
	private let setTotalPhotos = 26
	private let setTotalPages = 2
	private let setCameras = ["FHAZ", "RHAZ"]
	
    override func setUp() {
		super.setUp()
        jsonData = dataFromJson(for: fileName)
    }
	
    override func tearDown() {
		super.tearDown()
    }
	
    func testDecodable() {
        do {
			let set = try decoder.decode(PhotoSet.self, from: jsonData)
			XCTAssert(set.sol == setSol, "The PhotoSet.sol property was not decoded properly. \(setSol) is the correct value, but the value decoded from the JSON was: \(set.sol)")
			XCTAssert(set.totalPhotos == setTotalPhotos, "The PhotoSet.totalPhotos property was not decoded properly. \(setTotalPhotos) is the correct value, but the value decoded from the JSON was: \(set.totalPhotos)")
			XCTAssert(set.totalPages == setTotalPages, "The PhotoSet.totalPages property was not decoded properly. \(setTotalPages) is the correct value, but the value decoded from the JSON was: \(set.totalPages)")
			XCTAssert(set.cameras == setCameras, "The PhotoSet.cameras property was not decoded properly. \(setCameras) is the correct value, but the value decoded from the JSON was: \(set.cameras)")
		} catch {
			XCTFail("""
				\(fileName).json was unable to be parsed by the initializer provided by conforming to the Decodable protocol. Check your implementation before continuing.
				Error:
					\(error)
				""")
		}
    }
}

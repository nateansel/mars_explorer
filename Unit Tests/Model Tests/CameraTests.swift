//
//  CameraTests.swift
//  Unit Tests
//
//  Created by Nathan Ansel on 12/1/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import XCTest
@testable import Mars_Explorer

class CameraTests: XCTestCase {
	
	var jsonData: Data = Data()
	let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-mm-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	private var fileName = "camera_sample"
	private let cameraName = "FHAZ"
	private let cameraFullName = "Front Hazard Avoidance Camera"
	
    override func setUp() {
		super.setUp()
		jsonData = dataFromJson(for: fileName)
    }
	
    override func tearDown() {
		super.tearDown()
    }
	
    func testDecodable() {
        do {
			let camera = try decoder.decode(Camera.self, from: jsonData)
			XCTAssert(camera.name == cameraName, "The Camera.name property was not decoded properly. \(cameraName) is the correct value, but the value decoded from the JSON was: \(camera.name)")
			XCTAssert(camera.fullName == cameraFullName, "The Camera.name property was not decoded properly. \(cameraFullName) is the correct value, but the value decoded from the JSON was: \(camera.fullName)")
		} catch {
			XCTFail("""
				\(fileName).json was unable to be parsed by the initializer provided by conforming to the Decodable protocol. Check your implementation before continuing.
				Error:
					\(error)
				""")
		}
    }
}

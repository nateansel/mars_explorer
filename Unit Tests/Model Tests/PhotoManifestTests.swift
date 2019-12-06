//
//  PhotoManifestTests.swift
//  Mars ExplorerTests
//
//  Created by Nathan Ansel on 12/6/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import XCTest
@testable import Mars_Explorer

class PhotoManifestTests: XCTestCase {
	
	var jsonData: Data = Data()
	let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-MM-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	private var fileName = "manifest_sample"
	private let setSol = 2540
	
    override func setUp() {
		super.setUp()
        jsonData = dataFromJson(for: fileName)
    }
	
    override func tearDown() {
		super.tearDown()
    }
	
    func testDecodable() {
        do {
			let manifest = try decoder.decode(PhotoManifest.self, from: jsonData)
			guard let set = manifest.photoSets.first
				else {
				XCTFail("""
					\(fileName).json does not contain any PhotoSets in the manifest.
					""")
				return
			}
			XCTAssert(set.sol == setSol, "The Camera.name property was not decoded properly. \(setSol) is the correct value, but the value decoded from the JSON was: \(set.sol)")
		} catch {
			XCTFail("""
				\(fileName).json was unable to be parsed by the initializer provided by conforming to the Decodable protocol. Check your implementation before continuing.
				Error:
					\(error)
				""")
		}
    }
}

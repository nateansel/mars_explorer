//
//  BasicDecodableTests.swift
//  Unit Tests
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import XCTest

extension XCTestCase {
	func dataFromJson(for filename: String) -> Data {
		guard let url = Bundle(for: Self.self).url(forResource: filename, withExtension: "json")
			else {
				preconditionFailure("\(filename).json file was not found. Please ensure it is included in the Unit Tests build before proceeding.")
		}
		do {
			return try Data(contentsOf: url)
		} catch {
			preconditionFailure("""
				\(filename).json was unable to be coded into a Data object. Please check the file and continue.
				Error:
					\(error)
				""")
		}
	}
}

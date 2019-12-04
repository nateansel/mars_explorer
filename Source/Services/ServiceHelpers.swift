//
//  ServiceHelpers.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

extension URL {
	static let base = URL(string: "https://api.nasa.gov/mars-photos/api/v1")!
}

enum ServiceHelpers {
	static private let apiKey = "LWukPEZ6yczfW735RfTbktxSukJeJ2f9oxmfQW13"
	
	static func secure(url: URL) throws -> URL {
		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
			else {
				throw NSError(
					domain: url.absoluteString,
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "Unable to create URLComponents from URL: \(url.absoluteString)"])
		}
		components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
		guard let fullUrl = components.url
			else {
				throw NSError(
					domain: url.absoluteString,
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "Unable to create URL from URLComponents: \(components)"])
		}
		return fullUrl
	}
}

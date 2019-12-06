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
	
	/// Secures the given url by adding the api key to the url as a url parameter.
	///
	/// - parameter url: The url to be secured
	///
	static func secure(url: URL) throws -> URL {
		return try add(parameters: ["api_key": apiKey], to: url)
	}
	
	static func add(parameters: [String: String], to url: URL) throws -> URL {
		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
			else {
				throw NSError(
					domain: url.absoluteString,
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "Unable to create URLComponents from URL: \(url.absoluteString)"])
		}
		if components.queryItems == nil {
			components.queryItems = []
		}
		for key in parameters.keys {
			components.queryItems?.append(URLQueryItem(name: key, value: parameters[key]))
		}
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

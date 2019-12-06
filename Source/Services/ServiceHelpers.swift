//
//  ServiceHelpers.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

extension URL {
	/// The base url for the Mars Rover API. All requests should be based on this value.
	static let base = URL(string: "https://api.nasa.gov/mars-photos/api/v1")!
}

/// A namespace for containing the helper methods for networking abilities.
enum ServiceHelpers {
	/// The api key to use to secure all requests to the API.
	static private let apiKey = "LWukPEZ6yczfW735RfTbktxSukJeJ2f9oxmfQW13"
	
	/// Secures the given url by adding the api key to the url as a url parameter and returns a new `URL` object.
	///
	/// - parameter url: The url to be secured.
	/// - returns: Returns the url provided with the API key attached.
	/// - throws: Throws an error if there is an issue in converting the given url to a `URLComponents` object and back
	///   to a `URL` object again (after adding the API key).
	static func secure(url: URL) throws -> URL {
		return try add(parameters: ["api_key": apiKey], to: url)
	}
	
	/// Add the provided parameters to the given url and returns a new `URL` object.
	///
	/// - parameter parameters: The parameters to be added to the url.
	/// - parameter url: The url to add parameters to.
	/// - returns: Returns the url provided with the parameters attached.
	/// - throws: Throws an error if there is an issue in converting the given url to a `URLComponents` object and back
	///   to a `URL` object again (after adding the API key).
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

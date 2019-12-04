//
//  RoverService.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

fileprivate extension URL {
	static let roverList = base.appendingPathComponent("rovers")
}

class RoverService: RoversManager {
	
	private let session = URLSession(configuration: .default)
	private let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-mm-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	private struct RoversResult: Decodable {
		let rovers: [Rover]
	}
	
	func retrieveRovers(success: @escaping ([Rover]) -> Void, failure: @escaping (Error) -> Void) {
		// Create the request
		guard var components = URLComponents(url: .roverList, resolvingAgainstBaseURL: false)
			else {
				failure(NSError(
					domain: URL.roverList.absoluteString,
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "Unable to create URLComponents from URL: \(URL.roverList.absoluteString)"]))
				return
		}
		components.queryItems = [URLQueryItem(name: "api_key", value: ServiceHelpers.apiKey)]
		guard let url = components.url
			else {
				failure(NSError(
					domain: URL.roverList.absoluteString,
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "Unable to create URL from URLComponents: \(components)"]))
				return
		}
		
		// Start the request
		let task = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
			if let error = error {
				DispatchQueue.main.async {
					failure(error)
				}
			} else if let data = data {
				do {
					let result = try self.decoder.decode(RoversResult.self, from: data)
					DispatchQueue.main.async {
						success(result.rovers)
					}
				} catch {
					DispatchQueue.main.async {
						failure(error)
					}
				}
			} else {
				DispatchQueue.main.async {
					failure(NSError(
						domain: URL.roverList.absoluteString,
						code: -1,
						userInfo: [NSLocalizedDescriptionKey: "No data returned from request."]))
				}
			}
		}
		task.resume()
	}
}

//
//  RoverService.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

fileprivate extension URL {
	/// The `URL` for retrieving a list of rovers.
	static let roverList = base.appendingPathComponent("rovers")
}

/// An object to contains all of the networking requests needed to retrieve rovers from the API.
class RoverService {
	
	private let session = URLSession(configuration: .default)
	private let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-mm-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	
	/// A simple struct used to decode the value retrieved from the API that contains a list of rovers.
	private struct RoversResult: Decodable {
		let rovers: [Rover]
	}
	
	
	/// Retrieves a list of rovers.
	///
	/// - parameters:
	///   - success: A block to run if the API request is successful. Will contain a list of `Rover`s.
	///   - rovers: The list of `Rover`s retrieved from the API.
	///   - failure: A block to run if the API request fails. Will contain an `Error`.
	///   - error: The error encountered when the network request fails.
	func retrieveRovers(success: @escaping (_ rovers: [Rover]) -> Void, failure: @escaping (_ error: Error) -> Void) {
		do {
			let url = try ServiceHelpers.secure(url: .roverList)
			
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
							domain: url.absoluteString,
							code: -1,
							userInfo: [NSLocalizedDescriptionKey: "No data returned from request."]))
					}
				}
			}
			task.resume()
		} catch {
			failure(error)
		}
	}
}

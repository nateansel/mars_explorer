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

//
//  PhotoService.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

fileprivate extension URL {
	static func photos(for rover: Rover) -> URL {
		return base.appendingPathComponent("rovers/\(rover.name)/photos")
	}
}

class PhotoService {
	
	private let session = URLSession(configuration: .default)
	private let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-mm-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	private struct PhotosResult: Decodable {
		let photos: [Photo]
	}
	
	func retrievePhotos(for rover: Rover, success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void) {
		do {
			let url = try ServiceHelpers.secure(url: .photos(for: rover))
			
			// Start the request
			let task = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
				if let error = error {
					DispatchQueue.main.async {
						failure(error)
					}
				} else if let data = data {
					do {
						let result = try self.decoder.decode(PhotosResult.self, from: data)
						DispatchQueue.main.async {
							success(result.photos)
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

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
		base.appendingPathComponent("rovers/\(rover.name.lowercased())/photos")
	}
	
	static func manifest(for rover: Rover) -> URL {
		base.appendingPathComponent("manifests/\(rover.name.lowercased())")
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
	
	// MARK: - Methods
	
	private struct PhotosManifestResult: Decodable {
		let photoManifest: PhotoManifest
	}
	
	func retrieveManifest(for rover: Rover, success: @escaping (PhotoManifest) -> Void, failure: @escaping (Error) -> Void) {
		do {
			let url = try ServiceHelpers.secure(url: .manifest(for: rover))
			
			// Start the request
			let task = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
				if let error = error {
					DispatchQueue.main.async {
						failure(error)
					}
				} else if let data = data {
					do {
						let result = try self.decoder.decode(PhotosManifestResult.self, from: data)
						DispatchQueue.main.async {
							success(result.photoManifest)
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
	
	private struct PhotosResult: Decodable {
		let photos: [Photo]
	}
	
	func retrievePhotos(for rover: Rover, camera: Camera? = nil, page: Int = 0, sol: Int, success: @escaping ([Photo]) -> Void, failure: @escaping (Error) -> Void) {
		do {
			var url = try ServiceHelpers.secure(url: .photos(for: rover))
			var parameters = ["page": "\(page)", "sol": "\(sol)"]
			if let camera = camera {
				parameters["camera"] = camera.name
			}
			url = try ServiceHelpers.add(parameters: parameters, to: url)
			print(url)
			
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
	
	func retrievePhotoData(for photo: Photo, success: @escaping (PhotoData) -> Void, failure: @escaping (Error) -> Void) {
		guard let url = URL(string: photo.imgSrc)
			else {
				failure(NSError(
					domain: photo.imgSrc,
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "URL could not be created from image source."]))
				return
		}
		// Start the request
		let task = session.dataTask(with: URLRequest(url: URL(string: photo.imgSrc)!)) { (data, response, error) in
			if let error = error {
				DispatchQueue.main.async {
					failure(error)
				}
			} else if let data = data {
				let photoData = PhotoData(photoID: photo.id, data: data)
				PhotoDataContainer.shared.store(photoData)
				DispatchQueue.main.async {
					success(photoData)
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
	}
}

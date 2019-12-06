//
//  PhotoService.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

fileprivate extension URL {
	/// The `URL` for retrieving a set of photos for the given rover.
	///
	/// - parameter rover: The rover to retrieve photos for.
	/// - returns: The `URL` for retrieveing a list of photos for the provided rover.
	static func photos(for rover: Rover) -> URL {
		base.appendingPathComponent("rovers/\(rover.name.lowercased())/photos")
	}
	
	/// The `URL` for retrieving a photo manifest for the given rover.
	///
	/// - parameter rover: The rover to retrieve a photo manifest for.
	/// - returns: The `URL` for retrieveing a list of photos for the provided rover.
	static func manifest(for rover: Rover) -> URL {
		base.appendingPathComponent("manifests/\(rover.name.lowercased())")
	}
}

/// An object to contains all of the networking requests needed to retrieve photos from the API.
class PhotoService {
	
	private let session = URLSession(configuration: .default)
	private let decoder: JSONDecoder = {
		$0.dateDecodingStrategy = .formatted({
			$0.dateFormat = "yyyy-MM-dd"
			return $0
			}(DateFormatter()))
		$0.keyDecodingStrategy = .convertFromSnakeCase
		return $0
	}(JSONDecoder())
	
	/// A shared `PhotoService` object that can be used to simplify the photo data retreval requests.
	static var shared = PhotoService()
	
	// MARK: - Methods
	
	/// A simple struct used to decode the value retrieved from the API that contains a manifest.
	private struct PhotosManifestResult: Decodable {
		let photoManifest: PhotoManifest
	}
	
	/// Retrieves a photo manifest for the given rover.
	///
	/// - parameters:
	///   - rover: The rover to retrieve a manifest for.
	///   - success: A block to run if the API request is successful. Will contain a `PhotoManifest`.
	///   - manifest: The `PhotoManifest` retrieved from the API.
	///   - failure: A block to run if the API request fails. Will contain an `Error`.
	///   - error: The error encountered when the network request fails.
	func retrieveManifest(for rover: Rover, success: @escaping (_ manifest: PhotoManifest) -> Void, failure: @escaping (_ error: Error) -> Void) {
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
	
	/// A simple struct used to decode the value retrieved from the API that contains a list of photos.
	private struct PhotosResult: Decodable {
		let photos: [Photo]
	}
	
	/// Retrieves a list of photos for the given rover, camera, and Sol at the given page.
	///
	/// - parameters:
	///   - rover: The rover to retrieve photos for.
	///   - camera: The camera to filter the photos for. This value is optional and defaults to `nil`.
	///   - page: The page of photos to retrieve. This value defaults to `0`.
	///   - sol: The Sol to filter photos for.
	///   - success: A block to run if the API request is successful. Will contain an array of `Photo`s.
	///   - photos: The list of `Photo`s retrieved from the API.
	///   - failure: A block to run if the API request fails. Will contain an `Error`.
	///   - error: The error encountered when the network request fails.
	func retrievePhotos(for rover: Rover, camera: Camera? = nil, page: Int = 0, sol: Int, success: @escaping (_ photos: [Photo]) -> Void, failure: @escaping (_ error: Error) -> Void) {
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
	
	/// Retrieves the image data for the given photo. Uses the url contained in `Photo.imgSrc`.
	///
	/// - parameters:
	///   - photo: The photo to retrieve image data for.
	///   - success: A block to run if the API request is successful. Will contain a `PhotoData`.
	///   - photoData: The image data for the given photo.
	///   - failure: A block to run if the API request fails. Will contain an `Error`.
	///   - error: The error encountered when the network request fails.
	func retrievePhotoData(for photo: Photo, success: @escaping (_ photoData: PhotoData) -> Void, failure: @escaping (_ error: Error) -> Void) {
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

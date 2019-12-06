//
//  PhotoDataContainer.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// An object used to cache photo image data to increase app performance.
class PhotoDataContainer {
	
	/// The current cache data.
	private var data: [PhotoData] = []
	
	/// A shared instance of this cache so that this app is using the same cache everywhere. This elementates duplicated
	/// information.
	static let shared = PhotoDataContainer()
	
	/// Store the given image data in the cache. If data for the attached photo is found, it is overwritten with the
	/// provided value.
	///
	/// - parameter photoData: The image data to save in the cache.
	func store(_ photoData: PhotoData) {
		guard let index = data.firstIndex(where: { $0.photoID == photoData.photoID }) else {
			data.append(photoData)
			return
		}
		data[index] = photoData
	}
	
	/// If data exists for the given photo, the data is returned.
	///
	/// - parameter photo: The photo to retrieve data for.
	/// - returns: If image data is found for the given photo, the value is returned.
	func data(for photo: Photo) -> PhotoData? {
		guard let index = data.firstIndex(where: { $0.photoID == photo.id }) else { return nil }
		return data[index]
	}
}

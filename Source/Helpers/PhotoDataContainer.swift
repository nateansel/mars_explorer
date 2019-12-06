//
//  PhotoDataContainer.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class PhotoDataContainer {
	
	private var data: [PhotoData] = []
	
	static let shared = PhotoDataContainer()
	
	func store(_ photoData: PhotoData) {
		guard let index = data.firstIndex(where: { $0.photoID == photoData.photoID }) else {
			data.append(photoData)
			return
		}
		data[index] = photoData
	}
	
	func data(for photo: Photo) -> PhotoData? {
		guard let index = data.firstIndex(where: { $0.photoID == photo.id }) else { return nil }
		return data[index]
	}
}

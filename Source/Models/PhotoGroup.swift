//
//  PhotoGroup.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/4/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class PhotoGroup {
	let date: Date
	var photos: [Photo]
	
	init(date: Date, photos: [Photo]) {
		self.date = date
		self.photos = photos
	}
}

extension PhotoGroup {
	static func createPhotoGroups(from photos: [Photo]) -> [PhotoGroup] {
		var array: [PhotoGroup] = []
//		var currentEarthDate = Date()
		for photo in photos { //.sorted(by: { $0.earthDate > $1.earthDate }) {
			array.append(PhotoGroup(date: Date(), photos: [photo]))
		}
		return array
	}
	
	static func appendPhotoGroups() {}
}

extension Array where Element: PhotoGroup {
	init(photos: [Photo]) {
		self.init()
		var currentEarthDate = Date()
		var currentPhotos: [Photo] = []
		for photo in photos.sorted(by: { $0.earthDate >= $1.earthDate }) {
			if Calendar.current.isDate(photo.earthDate, inSameDayAs: currentEarthDate) {
				currentPhotos.append(photo)
			} else {
				if !currentPhotos.isEmpty {
					// Force casting as Element to fix compiler error. The `where` clause for this extension guarantees this is true
					append(PhotoGroup(date: currentEarthDate, photos: currentPhotos) as! Element)
				}
				currentEarthDate = photo.earthDate
				currentPhotos = [photo]
			}
		}
		append(PhotoGroup(date: currentEarthDate, photos: currentPhotos) as! Element)
	}
	
	mutating func append(photos: [Photo]) {
		var currentEarthDate = last?.date ?? Date()
		var currentPhotos: [Photo] = last?.photos ?? []
		for photo in photos.sorted(by: { $0.earthDate >= $1.earthDate }) {
			if Calendar.current.isDate(photo.earthDate, inSameDayAs: currentEarthDate) {
				currentPhotos.append(photo)
			} else {
				// Force casting as Element to fix compiler error. The `where` clause for this extension guarantees this is true
				append(PhotoGroup(date: currentEarthDate, photos: currentPhotos) as! Element)
				currentEarthDate = photo.earthDate
				currentPhotos = [photo]
			}
		}
		append(PhotoGroup(date: currentEarthDate, photos: currentPhotos) as! Element)
	}
}

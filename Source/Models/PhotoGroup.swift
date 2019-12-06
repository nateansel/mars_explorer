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

extension Array where Element: PhotoGroup {
	init(photos: [Photo]) {
		self.init()
		guard !photos.isEmpty else { return }
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
	
	@discardableResult
	mutating func append(photos: [Photo]) -> (rowsInserted: [IndexPath], sectionsInserted: [Int]) {
		var rows: [Int] = []
		let originalCount = count
		let currentSection = count - 1
		let otherPhotoGroups: [PhotoGroup] = .init(photos: photos)
		if let firstDate = otherPhotoGroups.first?.date,
			let lastDate = last?.date,
			Calendar.current.isDate(firstDate, inSameDayAs: lastDate) {
			rows = Array<Int>(last!.photos.count..<(last!.photos.count + otherPhotoGroups.first!.photos.count))
			last?.photos.append(contentsOf: otherPhotoGroups.first!.photos)
			append(contentsOf: otherPhotoGroups.dropFirst() as! ArraySlice<Element>)
		} else {
			append(contentsOf: otherPhotoGroups as! [Element])
		}
		return (rowsInserted: rows.map({ IndexPath(row: $0, section: originalCount - 1) }),
				sectionsInserted: Array<Int>(originalCount..<count))
	}
}

//
//  PhotoGroup.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/4/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// An object used to organize photos by earth date. This object is used exclusively in the Photos list screen to
/// simplify displaying sections of photos.
class PhotoGroup {
	/// The date on which these photos were taken.
	let date: Date
	
	/// The photos included in this group.
	var photos: [Photo]
	
	init(date: Date, photos: [Photo]) {
		self.date = date
		self.photos = photos
	}
}

// MARK: - Array init & appending

extension Array where Element: PhotoGroup {
	/// Initialize an array of `PhotoGroup` objects with a list of `Photo` objects. This method will automatically sort
	/// and group the photos by date.
	///
	/// - parameter photos: The list of photos to use to initialize an array of `PhotoGroup` objects.
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
	
	/// Append `PhotoGroup` objects to this array with a given list of `Photo` objects. This method will automatically
	/// sort and group the photos by date.
	///
	/// - parameter photos: The list of photos to append to this array.
	/// - returns: The rows and sections that have been inserted into this array. Rows will be the indices for rows
	///   appended to the last element in this array. Sections will be the indicies for additional `PhotoGroup` objects
	///   that have been appended.
	@discardableResult
	mutating func append(photos: [Photo]) -> (rowsInserted: [IndexPath], sectionsInserted: [Int]) {
		var rows: [Int] = []
		let originalCount = count
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

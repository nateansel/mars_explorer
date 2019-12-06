//
//  PhotoManifestDataSource.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// An object used to track which photos from a manifest have been retrieved and determine the page and Sol to use when
/// fetching the next list of photos.
class PhotoManifestDataSource {
	/// The manifest this object is tracking.
	let manifest: PhotoManifest
	
	/// The page to be retrieved in the next api request.
	var currentPage: Int
	
	/// The Sol to be retrieved in the next api request.
	var currentSol: Int { manifest.photoSets[index].sol }
	
	/// If there are no more photos to be retrieved.
	var isAtEndOfList: Bool { index == manifest.photoSets.count }
	
	/// The index of the next `PhotoSet` to be used in the next api request.
	private var index: Int
	
	init(manifest: PhotoManifest) {
		self.manifest = manifest
		currentPage = 0
		index = 0
	}
	
	/// Increment the current page and Sol as needed.
	///
	/// If the current page overflows the current Sol's total pages, increments the Sol as well as reseting the current
	/// page.
	func advance() {
		if currentPage < manifest.photoSets[index].totalPages {
			currentPage += 1
		} else {
			index += 1
			currentPage = 0
		}
	}
	
	/// Resets the current page and Sol.
	///
	/// Essentially resets to the beginning of the list.
	func reset() {
		index = 0
		currentPage = 0
	}
}

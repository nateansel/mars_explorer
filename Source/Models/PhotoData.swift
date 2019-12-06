//
//  PhotoData.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// An object that contains the image data for a `Photo`.
class PhotoData {
	/// The id of the `Photo` this data is associated with.
	var photoID: Int
	
	/// The raw image data for a `Photo`.
	var data: Data
	
	init(photoID: Int, data: Data) {
		self.photoID = photoID
		self.data = data
	}
}

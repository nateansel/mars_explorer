//
//  PhotoData.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class PhotoData {
	var photoID: Int
	var data: Data
	
	init(photoID: Int, data: Data) {
		self.photoID = photoID
		self.data = data
	}
}

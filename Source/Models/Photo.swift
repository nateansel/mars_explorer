//
//  Photo.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// An object that contains a summary of a photo.
class Photo: Decodable {
	/// The unique id of this photo.
	let id: Int
	
	/// The Sol on which this photo was taken.
	let sol: Int
	
	/// The url where the image data for this photo resides.
	let imgSrc: String
	
	/// The date this photo on which this photo was taken.
	let earthDate: Date
	
	/// The camera that took this photo.
	let camera: Camera
	
	/// The rover that took this photo.
	let rover: Rover

	init(id: Int, sol: Int, imgSrc: String, earthDate: Date, camera: Camera, rover: Rover) {
		self.id = id
		self.sol = sol
		self.imgSrc = imgSrc
		self.earthDate = earthDate
		self.camera = camera
		self.rover = rover
	}
}

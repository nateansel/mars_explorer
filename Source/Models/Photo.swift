//
//  Photo.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class Photo: Decodable {
	let id: Int
	let sol: Int
	let imgSrc: String
	let earthDate: Date
	let camera: Camera
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

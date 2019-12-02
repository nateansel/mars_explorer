//
//  Rover.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/1/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

enum RoverStatus: String, Decodable {
	case active
}

class Rover: Decodable {
	let id: Int
	let name: String
	let landingDate: Date
	let launchDate: Date
	let status: RoverStatus
	let maxSol: Int
	let maxDate: Date
	let totalPhotos: Int
	let cameras: [Camera]
	
	init(id: Int, name: String, landingDate: Date, launchDate: Date, status: RoverStatus, maxSol: Int, maxDate: Date, totalPhotos: Int, cameras: [Camera]) {
		self.id = id
		self.name = name
		self.landingDate = landingDate
		self.launchDate = launchDate
		self.status = status
		self.maxSol = maxSol
		self.maxDate = maxDate
		self.totalPhotos = totalPhotos
		self.cameras = cameras
	}
}

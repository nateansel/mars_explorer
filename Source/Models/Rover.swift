//
//  Rover.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/1/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// The status of a rover.
enum RoverStatus: String, Decodable {
	/// If the rover's mission is still active.
	case active
	
	/// If the rover's mission is complete.
	case complete
}

/// An object that contains a summary of a rover.
class Rover: Decodable {
	/// The unique id of this rover.
	let id: Int
	
	/// The name of this rover.
	let name: String
	
	/// The date this rover landed on Mars.
	let landingDate: Date
	
	/// The date this rover launched from Earth.
	let launchDate: Date
	
	/// The current status of this rover.
	let status: RoverStatus
	
	/// The last Sol this rover has photos for.
	let maxSol: Int?
	
	/// The last date this rover has photos for.
	let maxDate: Date?
	
	/// The total number of photos this rover has taken on Mars.
	let totalPhotos: Int?
	
	/// All the cameras on this rover.
	let cameras: [Camera]?
	
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

//
//  Rover.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/1/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

enum RoverStatus: String, Codable {
	case active
}

class Rover: Codable {
	let id: Int
	let name: String
	let landingDate: Date
	let launchDate: Date
	let status: RoverStatus
	let maxSol: Int
	let maxDate: Date
	let totalPhotos: Int
	let cameras: [Camera]
}

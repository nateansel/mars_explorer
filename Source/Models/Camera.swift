//
//  Camera.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/1/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// An object that contains a summary of a camera.
class Camera: Decodable {
	/// The abbreviated name of this camera. Usually only a few characters long.
	let name: String
	
	/// The human readable name of this camera.
	let fullName: String
	
	init(name: String, fullName: String) {
		self.name = name
		self.fullName = fullName
	}
}

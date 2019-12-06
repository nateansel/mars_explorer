//
//  PhotoSet.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

/// An object that contains a summary of a set of photos for a particular Sol.
class PhotoSet: Decodable {
	/// The Sol on which this photo set was taken.
	let sol: Int
	
	/// The total number of photos in this set.
	let totalPhotos: Int
	
	/// All the cameras that took photos on this sol.
	let cameras: [String]
	
	/// The total number of pages of requests for this set.
	let totalPages: Int

	init(sol: Int, totalPhotos: Int, cameras: [String]) {
		self.sol = sol
		self.totalPhotos = totalPhotos
		self.cameras = cameras
		let pages = totalPhotos / 25
		if totalPhotos % 25 > 0 {
			self.totalPages = pages + 1
		} else {
			self.totalPages = pages
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case sol, totalPhotos, cameras
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		sol = try container.decode(Int.self, forKey: .sol)
		totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
		cameras = try container.decode([String].self, forKey: .cameras)
		let pages = totalPhotos / 25
		if totalPhotos % 25 > 0 {
			self.totalPages = pages + 1
		} else {
			self.totalPages = pages
		}
	}
}

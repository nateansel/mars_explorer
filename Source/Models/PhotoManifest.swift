//
//  PhotoManifest.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class PhotoManifest: Decodable {
	let photoSets: [PhotoSet]
	
	init(photos: [PhotoSet]) {
		self.photoSets = photos.sorted(by: { $0.sol > $1.sol })
	}
	
	enum CodingKeys: String, CodingKey {
		case photoSets = "photos"
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.photoSets = try container.decode([PhotoSet].self, forKey: .photoSets).sorted(by: { $0.sol > $1.sol })
	}
}

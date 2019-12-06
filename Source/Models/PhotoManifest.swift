//
//  PhotoManifest.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class PhotoManifest: Decodable {
	let photos: [PhotoSet]
	
	init(photos: [PhotoSet]) {
		self.photos = photos.sorted(by: { $0.sol > $1.sol })
	}
	
	enum CodingKeys: String, CodingKey {
		case photos
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.photos = try container.decode([PhotoSet].self, forKey: .photos).sorted(by: { $0.sol > $1.sol })
	}
}

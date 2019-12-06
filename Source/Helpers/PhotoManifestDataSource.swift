//
//  PhotoManifestDataSource.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class PhotoManifestDataSource {
	let manifest: PhotoManifest
	
	var currentPage: Int
	var currentSol: Int { manifest.photoSets[index].sol }
	var isAtEndOfList: Bool { index == manifest.photoSets.count }
	
	private var index: Int
	
	init(manifest: PhotoManifest) {
		self.manifest = manifest
		currentPage = 0
		index = 0
	}
	
	func advance() {
		if currentPage < manifest.photoSets[index].totalPages {
			currentPage += 1
		} else {
			index += 1
			currentPage = 0
		}
	}
	
	func reset() {
		index = 0
		currentPage = 0
	}
}

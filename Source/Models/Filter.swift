//
//  Filter.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import Foundation

class Filter {
	let allRovers: [Rover]
	let allCameras: [Camera]
	
	var selectedRovers: [Rover]
	var selectedCameras: [Camera]
	var selectedSol: Int?
	var selectedEarthDate: Date?
}

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

	init(allRovers: [Rover], allCameras: [Camera], selectedRovers: [Rover], selectedCameras: [Camera], selectedSol: Int?, selectedEarthDate: Date?) {
		self.allRovers = allRovers
		self.allCameras = allCameras
		self.selectedRovers = selectedRovers
		self.selectedCameras = selectedCameras
		self.selectedSol = selectedSol
		self.selectedEarthDate = selectedEarthDate
	}
}

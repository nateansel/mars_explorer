//
//  RoversTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

protocol RoversTableViewControllerDelegate: class {
	func display(rover: Rover)
}

class RoversTableViewController: UITableViewController {
	
	var data: [Rover] = []
	
	var delegate: RoversTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// For testing
		data = [
			Rover(
				id: 5,
				name: "Curiosity",
				landingDate: Calendar.current.date(from: DateComponents(year: 2012, month: 8, day: 6))!,
				launchDate: Calendar.current.date(from: DateComponents(year: 2011, month: 11, day: 26))!,
				status: .active,
				maxSol: 2540,
				maxDate: Calendar.current.date(from: DateComponents(year: 2019, month: 9, day: 28))!,
				totalPhotos: 366206,
				cameras: [
					Camera(
						name: "FHAZ",
						fullName: "Front Hazard Avoidance Camera")
			])
		]
		
		tableView.register(RoverTableViewCell.self, forCellReuseIdentifier: "roverCell")
		tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "roverCell", for: indexPath) as! RoverTableViewCell
		cell.rover = data[indexPath.row]
		cell.accessoryType = .disclosureIndicator
		return cell
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.display(rover: data[indexPath.row])
	}
}

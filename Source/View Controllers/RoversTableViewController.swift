//
//  RoversTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

/// The delegate for the Rover List screen. Contains the navigation methods needed for this screen.
protocol RoversTableViewControllerDelegate: class {
	/// Informs the delegate that the details of the given rover should be displayed.
	///
	/// - parameter rover: The rover to display.
	func display(rover: Rover)
}

class RoversTableViewController: UITableViewController {
	
	/// The data to be displayed in this screen.
	var data: [Rover] = []
	
	/// The delegate for this screen. Navigation flows are passed to this delegate.
	var delegate: RoversTableViewControllerDelegate?
	
	/// The service object used by this screen to retrieve information from the API.
	var service: RoverService?

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Rovers"
		tableView.tableFooterView = UIView()
		tableView.register(RoverTableViewCell.self, forCellReuseIdentifier: "roverCell")
		refreshData()
    }
	
	func refreshData() {
		service?.retrieveRovers(success: { (rovers) in
			self.data = rovers
			self.tableView.reloadData()
		}, failure: { (error) in
			self.presentRetryAlert(title: "Internet Issue", message: "There was a problem downloading the list of Mars rovers. Please try again.", retryAction: {
				self.refreshData()
			})
			print(error)
		})
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

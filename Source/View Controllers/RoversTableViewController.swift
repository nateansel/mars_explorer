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

protocol RoversManager: class {
	func retrieveRovers(success: @escaping ([Rover]) -> Void, failure: @escaping (Error) -> Void)
}

class RoversTableViewController: UITableViewController {
	
	var data: [Rover] = []
	
	var delegate: RoversTableViewControllerDelegate?
	var manager: RoversManager?

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Rovers"
		tableView.tableFooterView = UIView()
		tableView.register(RoverTableViewCell.self, forCellReuseIdentifier: "roverCell")
		refreshData()
    }
	
	func refreshData() {
		manager?.retrieveRovers(success: { (rovers) in
			self.data = rovers
			self.tableView.reloadData()
		}, failure: { (error) in
			self.presentRetryAlert(title: "Internet Problem", message: "There was a problem downloading the list of Mars rovers. Please try again.", retryAction: {
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

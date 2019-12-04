//
//  RoverTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class RoverTableViewController: UITableViewController {
	
	var rover: Rover?
	
	convenience init() {
		self.init(style: .insetGrouped)
	}
	
	override init(style: UITableView.Style) {
		super.init(style: .insetGrouped)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		title = rover?.name
		
		tableView.register(RoverStatusTableViewCell.self, forCellReuseIdentifier: "roverStatusCell")
		tableView.register(ActivityDateTableViewCell.self, forCellReuseIdentifier: "activityDateCell")
		tableView.reloadData()
    }
	
	// MARK: - UITableViewDataSource
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			switch indexPath.row {
			case 0:
				let cell = tableView.dequeueReusableCell(withIdentifier: "roverStatusCell", for: indexPath) as! RoverStatusTableViewCell
				cell.status = rover?.status
				return cell
			case 1:
				let cell = tableView.dequeueReusableCell(withIdentifier: "activityDateCell", for: indexPath) as! ActivityDateTableViewCell
				cell.icon = UIImage(named: "launch")
				cell.date = rover?.launchDate
				cell.title = "Launched"
				return cell
			case 2:
				let cell = tableView.dequeueReusableCell(withIdentifier: "activityDateCell", for: indexPath) as! ActivityDateTableViewCell
				cell.icon = nil
				cell.date = rover?.landingDate
				cell.title = "Landed"
				return cell
			default: break
			}
		default: break
		}
		// This code should only be reached during development, as it causes a crash. This will never be reached in production.
		preconditionFailure("Was unable to determine which cell to display for IndexPath \(indexPath)")
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Info"
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return false
	}
}

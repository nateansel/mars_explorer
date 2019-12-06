//
//  RoverDetailTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

protocol RoverDetailTableViewControllerDelegate: class {
	func displayPhotos(for rover: Rover, and camera: Camera?)
}

class RoverDetailTableViewController: UITableViewController {
	
	var rover: Rover?
	
	var delegate: RoverDetailTableViewControllerDelegate?
	var isDisplayingCameras = false
	
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
		tableView.register(CameraTableViewCell.self, forCellReuseIdentifier: "cameraCell")
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
		tableView.reloadData()
    }
	
	// MARK: - UITableViewDataSource
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 3
		case 1:
			return isDisplayingCameras ? (rover?.cameras.count ?? 0) + 1 : 1
		case 2:
			return 1
		default:
			return 0
		}
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
			default:
				break
			}
		case 1:
			if indexPath.row == 0 {
				let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
				cell.textLabel?.text = isDisplayingCameras ? "Hide All Cameras" : "Show All Cameras"
				return cell
			}
			let cell = tableView.dequeueReusableCell(withIdentifier: "cameraCell", for: indexPath) as! CameraTableViewCell
			cell.camera = rover?.cameras[indexPath.row - 1]
			cell.accessoryType = .disclosureIndicator
			return cell
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
			cell.textLabel?.text = "All Photos"
			cell.accessoryType = .disclosureIndicator
			return cell
		default:
			break
		}
		// This code should only be reached during development, as it causes a crash. This will never be reached in production.
		preconditionFailure("Was unable to determine which cell to display for IndexPath \(indexPath)")
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0: return "Info"
		case 1: return "Cameras"
		case 2: return "Photos"
		default: return nil
		}
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return indexPath.section == 1 || indexPath.section == 2
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// Make sure we have a rover
		guard let rover = rover else {
			tableView.deselectRow(at: indexPath, animated: true)
			return
		}
		switch indexPath.section {
		case 1:
			if indexPath.row == 0 {
				// Deselect the camera toggle row
				tableView.deselectRow(at: indexPath, animated: true)
				isDisplayingCameras.toggle()
				let indexPaths = rover.cameras.indices.map({ IndexPath(row: $0 + 1, section: 1) })
				if isDisplayingCameras {
					tableView.cellForRow(at: indexPath)?.textLabel?.text = "Hide All Cameras"
					tableView.insertRows(at: indexPaths, with: .top)
				} else {
					tableView.cellForRow(at: indexPath)?.textLabel?.text = "Show All Cameras"
					tableView.deleteRows(at: indexPaths, with: .top)
				}
				return
			}
			delegate?.displayPhotos(for: rover, and: rover.cameras[indexPath.row - 1])
		case 2:
			delegate?.displayPhotos(for: rover, and: nil)
		default: break
		}
	}
}

//
//  PhotoDetailTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class PhotoDetailTableViewController: UITableViewController {
	
	private var dateFormatter: DateFormatter = {
		$0.dateStyle = .medium
		return $0
	}(DateFormatter())
	
	var photo: Photo? {
		didSet {
			
		}
	}
	
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
		title = "Photo"
		tableView.register(PhotoSquareTableViewCell.self, forCellReuseIdentifier: "photoCell")
		tableView.register(BasicInformationTableViewCell.self, forCellReuseIdentifier: "infoCell")
	}
	
	// MARK: - UITableViewDataSource
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0: return 1
		case 1: return 3
		default: return 0
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			guard let photo = photo, let data = PhotoDataContainer.shared.data(for: photo) else { return UITableViewCell() }
			let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoSquareTableViewCell
			cell.photoImage = UIImage(data: data.data)
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! BasicInformationTableViewCell
			switch indexPath.row {
			case 0:
				cell.title = "Rover"
				cell.detail = photo?.rover.name
			case 1:
				cell.title = "Camera"
				cell.detail = photo?.camera.name
			case 2:
				cell.title = "Date"
				if let date = photo?.earthDate {
					cell.detail = dateFormatter.string(from: date)
				} else {
					cell.detail = nil
				}
			default:
				cell.title = nil
				cell.detail = nil
			}
			return cell
		default:
			// This code should only be reached during development, as it causes a crash. This will never be reached in production.
			preconditionFailure("Was unable to determine which cell to display for IndexPath \(indexPath)")
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard indexPath.section == 0 else { return UITableView.automaticDimension }
		guard let photo = photo,
			let data = PhotoDataContainer.shared.data(for: photo),
			let image = UIImage(data: data.data)
			else { return .zero }
		return image.size.height / (image.size.width / tableView.contentSize.width)
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 1: return "Info"
		default: return nil
		}
	}
}

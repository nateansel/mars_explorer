//
//  PhotoDetailTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class PhotoDetailTableViewController: UITableViewController {
	
	/// If the camera's additional information is being displayed.
	private var isDisplayingCameraInfo = false
	
	/// The date formatter for this screen.
	private var dateFormatter: DateFormatter = {
		$0.dateStyle = .medium
		return $0
	}(DateFormatter())
	
	/// The photo being displayed.
	var photo: Photo?
	
	/// A helper variable to quickly find the image data for this photo.
	private var photoData: PhotoData? {
		guard let photo = photo else { return nil }
		return PhotoDataContainer.shared.data(for: photo)
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
		
		// Download the image data if it is not found in the cache.
		if photoData == nil {
			refreshData()
		}
	}
	
	/// Refreshes the image data for the photo being displayed on this screen.
	func refreshData() {
		guard let photo = photo else { return }
		PhotoService.shared.retrievePhotoData(
			for: photo,
			success: { (data) in
				PhotoDataContainer.shared.store(data)
				self.tableView.reloadData()
			}, failure: { (error) in
				self.presentRetryAlert(title: "Internet Issue", message: "There was a problem downloading this photo. Please try again.", retryAction: {
					self.refreshData()
				})
				print(error)
		})
	}
	
	// MARK: - UITableViewDataSource
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0: return 1
		case 1: return isDisplayingCameraInfo ? 4 : 3
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
			let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! BasicInformationTableViewCell
			switch indexPath.row {
			case 0:
				cell.title = "Rover"
				cell.detail = photo?.rover.name
			case 1:
				cell.title = "Camera"
				cell.detail = photo?.camera.name
			case 2:
				if isDisplayingCameraInfo {
					cell.title = nil
					cell.detail = photo?.camera.fullName
				} else {
					fallthrough // goes to `case 3:`'s body
				}
			case 3:
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
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return indexPath.row == 1
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		isDisplayingCameraInfo.toggle()
		if isDisplayingCameraInfo {
			tableView.insertRows(at: [IndexPath(row: 2, section: indexPath.section)], with: .top)
		} else {
			tableView.deleteRows(at: [IndexPath(row: 2, section: indexPath.section)], with: .top)
		}
	}
}

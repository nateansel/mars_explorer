//
//  PhotosTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

protocol PhotosTableViewControllerDelegate: class {
	func display(photo: Photo)
}

class PhotosTableViewController: UITableViewController {
	
	var rover: Rover?
	var camera: Camera?
	
	var delegate: PhotosTableViewControllerDelegate?
	var manager: PhotoService?
	
	private var rawData: [Photo] = []
	private var data: [PhotoGroup] = []
	private var dataSource: PhotoManifestDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Photos"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
		tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "photoCell")
		
		guard let rover = rover else { return }
		manager?.retrieveManifest(
			for: rover,
			success: { (manifest) in
				self.dataSource = PhotoManifestDataSource(manifest: manifest)
				self.refreshData(byAppending: false)
			}, failure: { (error) in
				print(error)
		})
    }
	
	func refreshData(byAppending: Bool) {
		guard let rover = rover else { return }
		if byAppending {
			manager?.retrievePhotos(
				for: rover,
				camera: camera,
				page: dataSource.currentPage,
				sol: dataSource.currentSol,
				success: { (photos) in
					self.appendData(with: photos)
					self.dataSource.advance()
				}, failure: { (error) in
					self.presentRetryAlert(title: "Internet Problem", message: "There was a problem downloading the list of Mars rovers. Please try again.", retryAction: {
						self.refreshData(byAppending: byAppending)
					})
			})
		} else {
			manager?.retrievePhotos(
				for: rover,
				camera: camera,
				page: dataSource.currentPage,
				sol: dataSource.currentSol,
				success: { (photos) in
					self.replaceData(with: photos)
					self.dataSource.advance()
				}, failure: { (error) in
					self.presentRetryAlert(title: "Internet Problem", message: "There was a problem downloading the list of Mars rovers. Please try again.", retryAction: {
						self.refreshData(byAppending: byAppending)
					})
			})
		}
	}
	
	func replaceData(with photos: [Photo]) {
		rawData = photos
		data = .init(photos: photos)
		tableView.reloadData()
	}
	
	func appendData(with photos: [Photo]) {
		rawData.append(contentsOf: photos)
		let toInsert = data.append(photos: photos)
		tableView.beginUpdates()
		tableView.insertRows(at: toInsert.rowsInserted, with: .top)
		tableView.insertSections(IndexSet(toInsert.sectionsInserted), with: .top)
		tableView.endUpdates()
	}

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
		return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data[section].photos.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
		cell.photo = data[indexPath.section].photos[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		return dateFormatter.string(from: data[section].date)
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.display(photo: data[indexPath.section].photos[indexPath.row])
	}
}

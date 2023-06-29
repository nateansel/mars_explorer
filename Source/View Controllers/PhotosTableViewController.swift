//
//  PhotosTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

/// The delegate for the Photo List screen. Contains the navigation methods needed for this screen.
protocol PhotosTableViewControllerDelegate: class {
	/// Informs the delegate that the given photo should be displayed.
	///
	/// - parameter photo: The photo to be displayed.
	func display(photo: Photo)
}

class PhotosTableViewController: UITableViewController {
	
	/// The rover this screen will be displaying photos for.
	var rover: Rover?
	
	/// The optional camer this screen will be displaying photos for.
	var camera: Camera?
	
	/// The delegate for this screen. Navigation flows are passed to this delegate.
	var delegate: PhotosTableViewControllerDelegate?
	
	/// The service object used by this screen to retrieve information from the API.
	var service: PhotoService?
	
	/// The data displayed by this screen.
	private var data: [PhotoGroup] = []
	
	/// The data source used to simplify service requests.
	private var dataSource: PhotoManifestDataSource!
	
	/// If this screen is currently loading information from the api or not. Used to keep from duplicating network
	/// requests.
	private var isLoading = false
	
	/// Used to track how many photos have been retrieved in the current request. If the value is less than 25, another
	/// request should be started.
	private var currentRetrievedCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Photos"
		tableView.register(PhotoSummaryTableViewCell.self, forCellReuseIdentifier: "photoCell")
		tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "loadingCell")
		
		// Retrieve the manifest for this rover and start loading photos.
		guard let rover = rover else { return }
		service?.retrieveManifest(
			for: rover,
			success: { (manifest) in
				self.dataSource = PhotoManifestDataSource(manifest: manifest)
				self.refreshData(byAppending: false)
			}, failure: { (error) in
				print(error)
		})
    }
	
	/// Retrieves data from the API. Either appends the results to the end of `data` or replaces the contents of `data`
	/// entirely.
	///
	/// - parameter byAppending: If the data should be appended to the end of `data`. If `false`, replaces the contents
	///   of `data`.
	func refreshData(byAppending: Bool) {
		isLoading = true
		guard let rover = rover else { return }
		if byAppending {
			service?.retrievePhotos(
				for: rover,
				camera: camera,
				page: dataSource.currentPage,
				sol: dataSource.currentSol,
				success: { (photos) in
					self.appendData(with: photos)
					self.dataSource.advance()
					self.isLoading = false
					self.currentRetrievedCount += photos.count
					if self.currentRetrievedCount < 25 {
						self.refreshData(byAppending: true)
					} else {
						self.currentRetrievedCount = 0
					}
				}, failure: { (error) in
					print(error)
					self.presentRetryAlert(title: "Internet Issue", message: "There was a problem downloading the list of photos. Please try again.", retryAction: {
						self.refreshData(byAppending: byAppending)
					})
			})
		} else {
			service?.retrievePhotos(
				for: rover,
				camera: camera,
				page: dataSource.currentPage,
				sol: dataSource.currentSol,
				success: { (photos) in
					self.replaceData(with: photos)
					self.dataSource.advance()
					self.isLoading = false
					self.currentRetrievedCount += photos.count
					if self.currentRetrievedCount < 25 {
						self.refreshData(byAppending: true)
					} else {
					   self.currentRetrievedCount = 0
				   }
				}, failure: { (error) in
					print(error)
					self.presentRetryAlert(title: "Internet Issue", message: "There was a problem downloading the list of photos. Please try again.", retryAction: {
						self.refreshData(byAppending: byAppending)
					})
			})
		}
	}
	
	/// Replaces the current set of displayed data with the provided data.
	///
	/// - parameter photos: The data to display on this screen. Replaces currently displayed data.
	func replaceData(with photos: [Photo]) {
		data = .init(photos: photos)
		tableView.reloadData()
	}
	
	/// Appends the given data set to the current set of displayed data.
	///
	/// - parameter photos: The data to append to the data currently displayed on this screen.
	func appendData(with photos: [Photo]) {
		let toInsert = data.append(photos: photos)
		tableView.beginUpdates()
		tableView.insertRows(at: toInsert.rowsInserted, with: .top)
		tableView.insertSections(IndexSet(toInsert.sectionsInserted), with: .top)
		tableView.endUpdates()
	}

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
		guard let dataSource = dataSource else { return data.count }
		return dataSource.isAtEndOfList ? data.count : data.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == data.count ? 1 : data[section].photos.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == data.count {
			return tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoSummaryTableViewCell
		cell.photo = data[indexPath.section].photos[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard section < data.count else { return nil }
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		return dateFormatter.string(from: data[section].date)
	}
	
	// MARK: - UITableViewDelegate
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return indexPath.section != data.count
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.display(photo: data[indexPath.section].photos[indexPath.row])
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.section == data.count {
			if !isLoading {
				refreshData(byAppending: true)
			}
		}
	}
}

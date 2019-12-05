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
	
	private var rawData: [Photo] = []
	private var data: [PhotoGroup] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Photos"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
		
		replaceData(with: [
			Photo(
				id: 8945,
				sol: 2540,
				imgSrc: "https://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02224/opgs/edr/fcam/FRA_594936755EDR_F0730550FHAZ00337M_.JPG",
				earthDate: Calendar.current.date(from: DateComponents(year: 2019, month: 9, day: 28))!,
				camera: Camera(
					name: "FHAZ",
					fullName: "Front Hazard Avoidance Camera"),
				rover: Rover(
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
							fullName: "Front Hazard Avoidance Camera"),
						Camera(
							name: "NAVCAM",
							fullName: "Navigation Camera")
				]))
		])
    }
	
	func replaceData(with photos: [Photo]) {
		rawData = photos
		data = .init(photos: photos)
	}
	
	func appendData(with photos: [Photo]) {
		rawData.append(contentsOf: photos)
		data.append(photos: photos)
	}

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
		return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data[section].photos.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
		cell.textLabel?.text = data[indexPath.section].photos[indexPath.row].rover.name
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		return dateFormatter.string(from: data[section].date)
	}
}

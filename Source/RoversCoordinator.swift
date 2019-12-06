//
//  RoversCoordinator.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class RoversCoordinator {
	let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		navigationController.navigationBar.prefersLargeTitles = true
		navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
	}
	
	func start() {
		let vc = RoversTableViewController()
		vc.delegate = self
		vc.manager = RoverService()
		navigationController.pushViewController(vc, animated: false)
	}
}

// MARK: - RoversTableViewControllerDelegate

extension RoversCoordinator: RoversTableViewControllerDelegate {
	func display(rover: Rover) {
		let vc = RoverDetailTableViewController()
		vc.rover = rover
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
}

extension RoversCoordinator: RoverDetailTableViewControllerDelegate {
	func displayPhotos(for rover: Rover, and camera: Camera?) {
		let vc = PhotosTableViewController()
		vc.manager = PhotoService()
		vc.rover = rover
		vc.camera = camera
		navigationController.pushViewController(vc, animated: true)
	}
}

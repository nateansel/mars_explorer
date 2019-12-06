//
//  AppCoordinator.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

/// An object that controls the flow through the application.
///
///
class AppCoordinator {
	/// The `UINavigationController` to use to display all the screens in the app. The root view controller of this
	/// coordinator.
	let navigationController: UINavigationController
	
	/// Basic initializer for this class. Must provide a `UINavigationController`.
	///
	/// - parameter navigationController: The `UINavigationController` that will be used in this object.
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		navigationController.navigationBar.prefersLargeTitles = true
	}
	
	/// Starts the application interface. Starts the interface with the Rovers list screen.
	///
	/// This method must be called for any view controllers in this coordinator to be initialized and displayed.
	func start() {
		let vc = RoversTableViewController()
		vc.delegate = self
		vc.service = RoverService()
		navigationController.pushViewController(vc, animated: false)
	}
}

// MARK: - RoversTableViewControllerDelegate

extension AppCoordinator: RoversTableViewControllerDelegate {
	func display(rover: Rover) {
		let vc = RoverDetailTableViewController()
		vc.rover = rover
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
}

// MARK: - RoverDetailTableViewControllerDelegate

extension AppCoordinator: RoverDetailTableViewControllerDelegate {
	func displayPhotos(for rover: Rover, and camera: Camera?) {
		let vc = PhotosTableViewController()
		vc.delegate = self
		vc.service = PhotoService.shared
		vc.rover = rover
		vc.camera = camera
		navigationController.pushViewController(vc, animated: true)
	}
}

// MARK: - PhotosTableViewControllerDelegate

extension AppCoordinator: PhotosTableViewControllerDelegate {
	func display(photo: Photo) {
		let vc = PhotoDetailTableViewController()
		vc.photo = photo
		navigationController.pushViewController(vc, animated: true)
	}
}

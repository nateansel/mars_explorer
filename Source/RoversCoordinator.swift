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
		let vc = RoverTableViewController()
		vc.rover = rover
		navigationController.pushViewController(vc, animated: true)
	}
}

//
//  AppCoordinator.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/1/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class AppCoordinator {
	let tabBarController: UITabBarController
	
	init(tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
	}
	
	func start() {
		let roverCoor = RoversCoordinator(navigationController: UINavigationController())
		roverCoor.start()
		tabBarController.setViewControllers([roverCoor.navigationController], animated: false)
	}
}

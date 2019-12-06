//
//  PhotoDetailTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class PhotoDetailTableViewController: UITableViewController {
	
	var photo: Photo? {
		didSet {
			
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - UITableViewDataSource
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
}

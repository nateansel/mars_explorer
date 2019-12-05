//
//  PhotoTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/4/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
	
	var photo: Photo?
	
	private let photoImageView: UIImageView = {
		$0.contentMode = .scaleAspectFill
		return $0
	}(UIImageView())
	
	private let titleLabel: UILabel = {
		return $0
	}(UILabel())
	
	
}

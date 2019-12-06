//
//  PhotoSquareTableViewController.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class PhotoSquareTableViewCell: UITableViewCell {
	
	// MARK: - Properties
	
	var photoImage: UIImage? {
		set { photoImageView.image = newValue }
		get { photoImageView.image }
	}
	
	// MARK: Views
	
	private let photoImageView: UIImageView = {
		$0.contentMode = .scaleToFill
		return $0
	}(UIImageView())
	
	// MARK: - Init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.addSubview(photoImageView)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		photoImageView.frame = bounds
	}
}

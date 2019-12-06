//
//  CameraTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/4/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class CameraTableViewCell: UITableViewCell {
	
	// MARK: - Properties
	
	/// The camera to display.
	var camera: Camera? {
		didSet {
			titleLabel.text = camera?.fullName
			photoCountLabel.text = nil
		}
	}
	
	// MARK: Views
	
	private let titleLabel: UILabel = {
		$0.numberOfLines = 0
		return $0
	}(UILabel())
	private let photoCountLabel: UILabel = {
		$0.textColor = .systemGray
		return $0
	}(UILabel())
	
	// MARK: - Methods
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.prepareViewsForConstraints([titleLabel, photoCountLabel])
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),

			photoCountLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			photoCountLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
			photoCountLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			photoCountLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		
		photoCountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
	}
}

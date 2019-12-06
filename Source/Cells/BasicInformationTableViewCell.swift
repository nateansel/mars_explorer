//
//  BasicInformationTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class BasicInformationTableViewCell: UITableViewCell {
	
	private let titleLabel: UILabel = {
		$0.numberOfLines = 0
		return $0
	}(UILabel())
	
	private let detailLabel: UILabel = {
		$0.textColor = .systemGray
		$0.textAlignment = .right
		return $0
	}(UILabel())
	
	var title: String? {
		set { titleLabel.text = newValue }
		get { titleLabel.text }
	}
	
	var detail: String? {
		set { detailLabel.text = newValue }
		get { detailLabel.text }
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.prepareViewsForConstraints([titleLabel, detailLabel])
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),

			detailLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			detailLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
			detailLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			detailLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		
		detailLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
	}
}

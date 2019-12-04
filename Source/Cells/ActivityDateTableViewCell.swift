//
//  ActivityDateTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class ActivityDateTableViewCell: UITableViewCell {
	
	static private let dateFormatter: DateFormatter = {
		$0.dateStyle = .medium
		return $0
	}(DateFormatter())
	
	// MARK: - Properties
	
	var title: String? {
		set { titleLabel.text = newValue }
		get { titleLabel.text }
	}
	
	var date: Date? {
		didSet {
			if let date = date {
				dateLabel.text = ActivityDateTableViewCell.dateFormatter.string(from: date)
			} else {
				dateLabel.text = nil
			}
		}
	}
	
	var icon: UIImage? {
		set { iconImageView.image = newValue }
		get { iconImageView.image }
	}
	
	// MARK: Views
	
	private let titleLabel = UILabel()
	private let dateLabel: UILabel = {
		$0.textAlignment = .right
		$0.textColor = .lightGray
		return $0
	}(UILabel())
	private let iconImageView: UIImageView = {
		$0.tintColor = .systemGray
		return $0
	}(UIImageView())
	
	// MARK: - Methods
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.prepareViewsForConstraints([iconImageView, titleLabel, dateLabel])
		
		NSLayoutConstraint.activate([
			iconImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			iconImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			iconImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
			
			titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			
			dateLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			dateLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			dateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
		])
		
		dateLabel.setContentHuggingPriority(.required, for: .horizontal)
	}
}

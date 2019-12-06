//
//  RoverStatusTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class RoverStatusTableViewCell: UITableViewCell {
	
	// MARK: - Properties
	
	var status: RoverStatus? {
		didSet {
			statusView.status = status ?? .active
			statusLabel.text = status?.rawValue.capitalized
		}
	}
	
	// MARK: Views
	
	private let titleLabel = UILabel()
	private let statusView = StatusView()
	private let statusLabel: UILabel = {
		$0.textAlignment = .right
		$0.textColor = .systemGray
		return $0
	}(UILabel())
	
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
		contentView.prepareViewsForConstraints([statusView, titleLabel, statusLabel])
		
		NSLayoutConstraint.activate([
			statusView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			statusView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			statusView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			statusView.widthAnchor.constraint(equalTo: statusView.heightAnchor),
			
			titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: statusView.trailingAnchor, constant: 8),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			
			statusLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			statusLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			statusLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			statusLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
		])
		
		statusLabel.setContentHuggingPriority(.required, for: .horizontal)
		titleLabel.text = "Status"
	}
}

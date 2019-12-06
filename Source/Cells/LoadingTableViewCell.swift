//
//  LoadingTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/5/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
	
	private let loadingView = UIActivityIndicatorView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		prepareViewForConstraints(loadingView)
		
		NSLayoutConstraint.activate([
			loadingView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			loadingView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			loadingView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			loadingView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		
		loadingView.startAnimating()
	}
}

//
//  PhotoTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/4/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
	
	// MARK: - Properties
	
	var photo: Photo? {
		didSet {
			guard let photo = photo
				else {
					photoImageView.image = nil
					titleLabel.text = nil
					return
			}
			titleLabel.text = photo.rover.name
			if let data = PhotoDataContainer.shared.data(for: photo) {
				photoImageView.image = UIImage(data: data.data)
			} else {
				photoImageView.image = nil
				PhotoService().retrievePhotoData(for: photo, success: { (data) in
					PhotoDataContainer.shared.store(data)
					if self.photo?.id == data.photoID {
						self.photoImageView.image = UIImage(data: data.data)
					}
				}, failure: { (error) in
					print(error)
				})
			}
		}
	}
	
	// MARK: Views
	
	private let photoImageView: UIImageView = {
		$0.contentMode = .scaleAspectFill
		$0.layer.cornerRadius = 8
		$0.layer.masksToBounds = true
		return $0
	}(UIImageView())
	
	private let titleLabel: UILabel = {
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
		contentView.prepareViewsForConstraints([photoImageView, titleLabel])
		
		NSLayoutConstraint.activate([
			photoImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.layoutMarginsGuide.topAnchor),
			photoImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor),
			photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
			photoImageView.widthAnchor.constraint(equalToConstant: 56),
			
			titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
		])
	}
}

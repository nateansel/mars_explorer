//
//  PhotoSummaryTableViewCell.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/4/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class PhotoSummaryTableViewCell: UITableViewCell {
	
	// MARK: - Properties
	
	private let dateFormatter: DateFormatter = {
		$0.dateStyle = .short
		return $0
	}(DateFormatter())
	
	/// The Photo to display.
	var photo: Photo? {
		didSet {
			guard let photo = photo
				else {
					photoImageView.image = nil
					roverLabel.text = nil
					cameraLabel.text = nil
					dateLabel.text = nil
					return
			}
			roverLabel.text = photo.rover.name
			cameraLabel.text = photo.camera.name
			dateLabel.text = dateFormatter.string(from: photo.earthDate)
			if let data = PhotoDataContainer.shared.data(for: photo) {
				photoImageView.image = UIImage(data: data.data)
			} else {
				photoImageView.image = nil
				PhotoService.shared.retrievePhotoData(for: photo, success: { (data) in
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
	private let roverLabel = UILabel()
	private let cameraLabel = UILabel()
	private let dateLabel: UILabel = {
		$0.textAlignment = .right
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
		contentView.prepareViewsForConstraints([photoImageView, roverLabel, cameraLabel, dateLabel])
		
		NSLayoutConstraint.activate([
			photoImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.layoutMarginsGuide.topAnchor),
			photoImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor),
			photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			photoImageView.widthAnchor.constraint(equalTo: photoImageView.heightAnchor),
			photoImageView.widthAnchor.constraint(equalToConstant: 56),
			
			roverLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			roverLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
			
			cameraLabel.topAnchor.constraint(equalTo: roverLabel.bottomAnchor, constant: 8),
			cameraLabel.leadingAnchor.constraint(equalTo: roverLabel.leadingAnchor),
			cameraLabel.trailingAnchor.constraint(equalTo: roverLabel.trailingAnchor),
			cameraLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			
			dateLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			dateLabel.leadingAnchor.constraint(equalTo: roverLabel.trailingAnchor, constant: 8),
			dateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		
		dateLabel.setContentHuggingPriority(.required, for: .horizontal)
	}
}

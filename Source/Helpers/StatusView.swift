//
//  StatusView.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

/// A custom view used to display a rover's status.
class StatusView: UIView {
	
	// MARK: - Properties
	
	/// The status to display.
	var status: RoverStatus = .active
	
	// MARK: Views
	
	private let symbolLayer = CAShapeLayer()
	
	// MARK: - Methods
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.addSublayer(symbolLayer)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		layer.addSublayer(symbolLayer)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		symbolLayer.frame = bounds
		let frame = CGRect(
			x: (bounds.width / 2) - 6,
			y: (bounds.height / 2) - 6, // centers the frame
			width: 12,
			height: 12)
		symbolLayer.path = UIBezierPath(ovalIn: frame).cgPath
		
		switch status {
		case .active: symbolLayer.fillColor = UIColor.green.cgColor
		case .complete: symbolLayer.fillColor = UIColor.red.cgColor
		}
	}
}

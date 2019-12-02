//
//  StatusView.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

class StatusView: UIView {
	
	var status: RoverStatus = .active
	
	// MARK: - Properties
	
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
			x: (bounds.width / 2) - 4,
			y: (bounds.height / 2) - 4, // centers the frame
			width: 8,
			height: 8)
		symbolLayer.path = UIBezierPath(ovalIn: frame).cgPath
		
		switch status {
		case .active: symbolLayer.fillColor = UIColor.green.cgColor
		case .complete: symbolLayer.fillColor = UIColor.red.cgColor
		}
	}
}

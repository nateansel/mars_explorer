//
//  UIView+Extensions.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/2/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

extension UIView {
	/// Prepares the provided view for constraints by first setting `translatesAutoresizingMaskIntoConstraints` to
	/// `false` and then adding the provided view as a subview to this view.
	func prepareViewForConstraints(_ view: UIView) {
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
	}
	
	/// Prepares the provided views for constraints by first setting `translatesAutoresizingMaskIntoConstraints` to
	/// `false` and then adding the provided views as a subview to this view. The views are added in same order as they
	/// are arranged in the array.
	func prepareViewsForConstraints(_ views: [UIView]) {
		views.forEach { self.prepareViewForConstraints($0) }
	}
}

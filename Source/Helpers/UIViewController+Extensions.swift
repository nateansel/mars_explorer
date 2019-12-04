//
//  UIViewController+Extensions.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

extension UIViewController {
	func presentRetryAlert(title: String, message: String?, retryAction: @escaping () -> Void) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(
			title: "Cancel",
			style: .cancel,
			handler: nil))
		alertController.addAction(UIAlertAction(
			title: "Retry",
			style: .default,
			handler: { _ in
				retryAction()
		}))
		present(alertController, animated: true, completion: nil)
	}
	
	func presentOkayAlert(title: String, message: String?, okayAction: (() -> Void)? = nil) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(
			title: "Okay",
			style: .default,
			handler: { _ in
				okayAction?()
		}))
		present(alertController, animated: true, completion: nil)
	}
}

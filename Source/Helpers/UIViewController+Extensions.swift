//
//  UIViewController+Extensions.swift
//  Mars Explorer
//
//  Created by Nathan Ansel on 12/3/19.
//  Copyright © 2019 Nathan Ansel. All rights reserved.
//

import UIKit

extension UIViewController {
	/// Creates and presents an alert with a Cancel and Retry button. If the Retry button is pressed, the retryAction
	/// block will be run.
	///
	/// - parameter title: The title for the alert.
	/// - parameter message: The message for the alert.
	/// - parameter retryAction: The block to run if the Retry button is pressed.
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
	
	/// Creates and presents an alert with an Okay button. If the Okay button is pressed, the okayAction block will
	/// be run.
	///
	/// - parameter title: The title for the alert.
	/// - parameter message: The message for the alert.
	/// - parameter okayAction: An optional block to run if the Okay button is pressed.
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

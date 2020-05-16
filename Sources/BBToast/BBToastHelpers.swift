//
//  BBToastHelpers.swift
//  BBToast
//
//  Created by Bibin Jacob Pulickal on 16/05/20.
//

import UIKit

public extension UIViewController {

    func showBBToast(_ message: String?, duration: Double = 2, setup: ((BBToast) -> Void)? = nil) {
        view.showBBToast(message, duration: duration, setup: setup)
    }
}

public extension UIView {

    func showBBToast(_ message: String?, duration: Double = 2, setup: ((BBToast) -> Void)? = nil) {

        guard let message = message else { return }
        let toast = BBToast(message)

        setup?(toast)
        toast.show(onView: self, forDuration: duration)
    }
}

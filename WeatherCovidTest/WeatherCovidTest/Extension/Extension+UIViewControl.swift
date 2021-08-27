//
//  Extension+UIViewControl.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/20/21.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}

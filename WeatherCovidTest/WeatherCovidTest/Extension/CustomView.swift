//
//  CustomView.swift
//  WeatherCovidTest
//
//  Created by trần nam on 8/24/21.
//

import Foundation

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        styleButton()
    }
    
    func styleButton() {
        setShawdow()
        
        //backgroundColor = .blue
        layer.cornerRadius = 10
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.gray.cgColor  // mau duong vien
    }
    
    func setShawdow() {
        layer.shadowColor   = UIColor.blue.cgColor
        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius  = 6
        layer.shadowOpacity = 0.3
        clipsToBounds       = true
        layer.masksToBounds = false
    }
}

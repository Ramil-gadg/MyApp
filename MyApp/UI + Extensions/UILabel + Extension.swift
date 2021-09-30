//
//  UILabel + Extension.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init (text: String, font: UIFont = .regularFont(), textColor: UIColor = .text()) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        numberOfLines = 0
    }
}

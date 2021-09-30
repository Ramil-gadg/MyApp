//
//  UIFont + Extension.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import UIKit

extension UIFont {
    
    static func regularFont (size: CGFloat = 14) -> UIFont {
        return UIFont(name: "KohinoorBangla-Regular", size: size)!
    }
    static func titleFont (size: CGFloat = 30) -> UIFont {
        return UIFont(name: "Zapfino", size: size)!
    }
    
}

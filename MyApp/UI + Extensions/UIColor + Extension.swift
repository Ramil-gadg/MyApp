//
//  UIColor + Extension.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import UIKit

extension UIColor {
    
    static func text () -> UIColor {
        return .darkGray
    }
    static func mainBackground () -> UIColor {
        return #colorLiteral(red: 0.7241822481, green: 0.9363681674, blue: 0.9176262617, alpha: 1)
    }
    static func buttonBackground () -> UIColor {
        return #colorLiteral(red: 0.9022139311, green: 0.351573348, blue: 0.9091923833, alpha: 1)
    }
    static func buttonTitleWithoutBackground () -> UIColor {
        return #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    static func textFieldBackground () -> UIColor {
        return #colorLiteral(red: 0.4755765796, green: 0.9078247547, blue: 0.9015433192, alpha: 1)
    }
    
}

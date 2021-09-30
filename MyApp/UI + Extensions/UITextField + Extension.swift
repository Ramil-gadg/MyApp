//
//  UITextField + Extension.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import UIKit


extension UITextField {
    
    convenience init (placeholder: String = "", isPassword: Bool = false) {
        self.init()
        self.placeholder = placeholder
        font = .regularFont()
        backgroundColor = .textFieldBackground()
        clearButtonMode = .whileEditing
        borderStyle = .bezel
        layer.masksToBounds = true
        
        if isPassword {
            isSecureTextEntry = true
        }
        
        
    }
}

//
//  Extension TextField.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import UIKit


extension UIButton {
    
    convenience init(title: String, font: UIFont = .regularFont(size: 20), cornerRadius: CGFloat = 8, hasBackgroundColor: Bool ) {
        self.init(type: .system)
        setTitle(title, for: .normal)
        titleLabel?.font = font
        layer.cornerRadius = cornerRadius
        if hasBackgroundColor {
            self.backgroundColor = UIColor.buttonBackground()
            setTitleColor(.white, for: .normal)
            layer.shadowOffset = CGSize(width: 0, height: 4)
            layer.shadowOpacity = 0.3
            layer.shadowRadius = 4
        } else {
            self.backgroundColor = .clear
            setTitleColor(.buttonTitleWithoutBackground(), for: .normal)
        }
        
        
        
        
       
        
    }
}


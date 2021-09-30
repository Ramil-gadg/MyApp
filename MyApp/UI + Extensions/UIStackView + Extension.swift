//
//  StackView + Extension.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init (firstView: UIView, secondView: UIView, verticalSpacing: CGFloat) {
        self.init(arrangedSubviews: [firstView, secondView])
        self.spacing = verticalSpacing
        axis = .vertical
    }
}

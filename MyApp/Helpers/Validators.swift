//
//  Validators.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 19.09.2021.
//

import Foundation

class Validators{
    
    static func isFilled (email: String?, password: String?) -> Bool {
        
        guard let email = email, let password = password, email != "", password != "" else { return false}
        return true
    }
    
    static func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
}

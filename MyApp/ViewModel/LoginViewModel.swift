//
//  LoginViewModel.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import Firebase

protocol LoginViewModelProtocol {
    var currentUser: User? { get }
    var email: String? { get }
    var password: String? { get }
    func signIn(email: String?, password: String?, completion: @escaping (User?, Error?) -> Void)
    
}


class LoginViewModel: LoginViewModelProtocol {
    
    var currentUser: User?
    
    var email: String?
    
    var password: String?
    
    func signIn(email: String?, password: String?, completion: @escaping (User?, Error?) -> Void) {
        guard Validators.isFilled(email: email, password: password) else {
            completion(nil, AuthError.notFilled)
            return
        }
        AuthManager.shared.signIn(email: email!, password: password!) {[weak self] user, error in
            if let user = user {
                self?.currentUser = user
            }
            completion(user, error)
        }
    }
    
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
}



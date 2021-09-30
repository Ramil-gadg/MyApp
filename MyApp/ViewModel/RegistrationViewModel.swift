//
//  RegistrationView.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 17.09.2021.
//

import Foundation
import Firebase

protocol RegistrationViewProtocol {
    var muser: MUser { get }
    var id: String? { get }
    var name: String { get }
    var lastName: String { get }
    var email: String { get }
    var password: String { get }
    func createUser(user: MUser, completion: @escaping (User?, Error?) -> Void)
}



class RegistrationViewModel: RegistrationViewProtocol {
    var muser: MUser
    
    func createUser(user: MUser, completion: @escaping (User?, Error?) -> Void) {
        guard Validators.isValidEmail(emailID: user.email) else {
            completion(nil, AuthError.invalidEmail)
            return
        }
        AuthManager.shared.createUser(email: user.email, password: user.password, name: user.name, lastName: user.lastName) {[weak self] user, error in
            if let user = user {
                self?.id = user.uid
                
            }
            completion(user, error)
            
        }
    }
    
    var id: String?
    
    var name: String {
        return muser.name
    }
    
    var lastName: String {
        return muser.lastName
    }
    
    var email: String{
        return muser.email
    }
    var password: String{
        return muser.password
    }
    
    init(user: MUser) {
        muser = user
        }
    }

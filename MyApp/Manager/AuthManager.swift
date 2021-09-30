//
//  DataBaseManager.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//
import Foundation
import Firebase

class AuthManager {
    
    static var shared = AuthManager()
    private init() {}
    func createUser(email: String, password: String, name: String, lastName: String, completion: @escaping (User?, Error?) -> ()) {
     
        guard Validators.isValidEmail(emailID: email) else {
            completion(nil, AuthError.invalidEmail)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion(result?.user, error)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (User?, Error?) -> ()) {
        guard Validators.isFilled(email: email, password: password) else {
            completion(nil, AuthError.notFilled)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(result?.user, error)
        }
    }
    
    func addStateDidChangeListener (completion: @escaping (_ user: User?) -> ()) {
        Auth.auth().addStateDidChangeListener { _, user in
            completion(user)
            
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController = LoginViewController()
//            UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
}

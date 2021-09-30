//
//  User.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import Foundation
import FirebaseFirestore


struct MUser {
    var id: String?
    var name: String
    var lastName: String
    var email: String
    var password: String
    
    
    init(id: String?, name: String, lastName: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    init?(document: DocumentSnapshot) {
    guard let data = document.data() else { return nil}
        guard let id = data["id"] as? String?,
              let name = data["name"] as? String,
        let lastName = data["lastName"] as? String,
        let email = data["email"] as? String,
        let password = data["password"] as? String
        else { return nil}
        self.id = id
        self.name = name
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    var presentetionToFireBase: [String: Any] {
        let dict = ["id":id,
                    "name": name,
                    "lastName":lastName,
                    "email":email,
                    "password":password]
        return dict as [String : Any]
    }
}

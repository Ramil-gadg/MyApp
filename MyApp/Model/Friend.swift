//
//  Friend.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 21.09.2021.
//

import Foundation
import FirebaseFirestore

struct Friend {
    
    var uid: String
    var name: String
    var lastName: String
    var isBest: Bool?
    var image: String?
    var description: String?
    
    var fullName: String {
        return "\(name) \(lastName)"
    }
    
    
    init(uid: String, name: String, lastName: String, description: String? = "", isBest: Bool? = false, image: String? = "") {
        self.uid = uid
        self.name = name
        self.lastName = lastName
        self.description = description
        self.isBest = isBest
        self.image = image
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let uid = data["uid"] as? String,
            let name = data["name"] as? String,
            let lastName = data["lastName"] as? String,
            let description = data["description"] as? String?,
            let isBest = data["isBest"] as? Bool?,
            let image = data["image"] as? String?
        else { return nil}
        self.uid = uid
        self.name = name
        self.lastName = lastName
        self.description = description
        self.isBest = isBest
        self.image = image
    }
    var presentetionToFireBase: [String: Any] {
        let dict = [ "uid":uid,
            "name":name,
                    "lastName":lastName,
                    "description":description ?? "",
                    "isBest":isBest ?? false,
                    "image":image ?? ""
        ] as [String : Any]
        return dict
    }
}

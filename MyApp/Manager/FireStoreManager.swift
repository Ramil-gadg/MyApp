//
//  FireStoreManager.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 20.09.2021.
//


import FirebaseFirestore
import FirebaseAuth

class FireStoreManager {
    
    static let shared = FireStoreManager()
    private init() {}
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func saveUserProfile (id: String, name: String, lastName: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        let muser = MUser(id: id, name: name, lastName: lastName, email: email, password: password)
        usersRef.document(muser.id!).setData(muser.presentetionToFireBase) { error in
            if let error = error {
                completion(error)
            }
        }
    }
    func getUserData(user: User, completion: @escaping (MUser?, Error?) -> Void) {
        let docRef = usersRef.document("\(user.uid)")
        docRef.getDocument { document, error in
            guard let document = document, document.exists else {
                completion(nil, error)
                return
            }
            let user = MUser(document: document)
            completion(user, nil)
        }
    }
    func saveFriend(user:MUser, name: String, lastName: String, completion: @escaping (Friend?, Error?) -> Void){
        let friend = Friend(uid: user.id!, name: name, lastName: lastName)
        let docRef = usersRef.document(friend.uid).collection("friends").document(friend.fullName)
        docRef.setData(friend.presentetionToFireBase) { error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(friend, nil)
            }
        }
        
    }
    
    func changeFriendsDescription(friend: Friend, text: String, completion: @escaping (Error?) -> Void){
        let docRef = usersRef.document(friend.uid).collection("friends").document(friend.fullName)
        docRef.updateData(["description" : text]) { error in
            if let error = error{
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
    func changeFriendsImageUrlString(friend: Friend, text: String, completion: @escaping (Error?) -> Void){
        let docRef = usersRef.document(friend.uid).collection("friends").document(friend.fullName)
        docRef.updateData(["image" : text]) { error in
            if let error = error{
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
    func changeFriendsBestOrNot(best: Bool, friend: Friend, completion: @escaping (Error?) -> Void){
        let docRef = usersRef.document(friend.uid).collection("friends").document(friend.fullName)
        docRef.updateData(["isBest" : best]) { error in
            if let error = error{
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
    func getFriends(user: MUser, completion: @escaping ([Friend]?, Error?) -> Void) {
        usersRef.document(user.id!).collection("friends").getDocuments { snapshot, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            var friends = [Friend]()
            guard let storeFriends = snapshot?.documents, !storeFriends.isEmpty else {
                completion([Friend](), nil)
                return}
            for storeFriend in storeFriends {
                guard let friend = Friend(document: storeFriend) else { continue }
                friends.append(friend)
            }
            completion(friends, nil)
        }
    }
    
    func deleteFriend(user: MUser, friend: Friend) {
        usersRef.document(user.id!).collection("friends").document(friend.fullName).delete()
    }
}

//
//  FireBaseStorageManager.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 23.09.2021.
//

import FirebaseAuth
import FirebaseStorage

class FireBaseStorageManager {
    
    static var shared = FireBaseStorageManager()
    
    private init() {}
    
   private let storageRef = Storage.storage().reference()
    
   private var friendsAvatarsRef: StorageReference {
        let ref = storageRef.child("friends")
        return ref
    }
    
    
    
    func uploadFriendPhoto(friend: Friend, image: UIImage, completion: @escaping (Error?) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
            return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        friendsAvatarsRef.child(friend.fullName).putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                completion(error)
                return
            }
            self.friendsAvatarsRef.child(friend.fullName).downloadURL { url, error in
                guard let url = url else {
                    completion(error)
                    return
                }
                let stringURL = url.absoluteString
                FireStoreManager.shared.changeFriendsImageUrlString(friend: friend, text: stringURL) { error in
                    guard error == nil else {
                        completion(error)
                        return
                    }
                }
            }
        }
    }
}

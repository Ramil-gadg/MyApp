//
//  InfoAboutFriendViewController.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 21.09.2021.
//

import UIKit



class InfoAboutFriendViewController: UIViewController, UITextViewDelegate {
    
    var currentFriend: Friend
    var buttonColor = false
    
    var gradient: CAGradientLayer = {
      let gradient = CAGradientLayer()
        gradient.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        return gradient
    }()
    
    
    var friendImage = ProfileCircleImage()
    var descriptionAboutFriend: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    var descriptionText: UITextView = {
        var textView = UITextView()
        textView.font = .regularFont()
        textView.isEditable = false
        textView.textAlignment = .left
        textView.backgroundColor = .white
        return textView
    }()
    
    var nameText: UILabel = {
        var textView = UILabel()
        textView.font = .titleFont(size: 16)
        textView.text = "Name LastName"
        textView.tintColor = .text()
        textView.textAlignment = .left
        return textView
    }()
    
    var changeTextButton: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = .text()
        button.layer.cornerRadius = 6
        button.layer.shadowRadius = 3
        button.layer.shadowOffset = CGSize(width: -3, height: 3)
        button.layer.shadowOpacity = 0.4
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.text().cgColor
        button.addTarget(self, action: #selector(textViewEnable), for: .touchUpInside)
        return button
    }()
    
    var bestFriendButton: UIButton = {
        let button = UIButton(type:.system)
        button.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
        button.layer.cornerRadius = 15
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 0.5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(bestFriend), for: .touchUpInside)
        return button
    }()
    
    init(currentFriend: Friend) {
        self.currentFriend = currentFriend
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        descriptionText.text = currentFriend.description
        nameText.text = currentFriend.name
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionText.delegate = self
        friendImage.button.addTarget(self, action: #selector(setImage), for: .touchUpInside)
        greate()
        friendImage.imageView.image = #imageLiteral(resourceName: "person")
        DispatchQueue.global().async {
            guard let url = URL(string: self.currentFriend.image!), let imageData = try? Data.init(contentsOf: url)  else {
            return
        }
            DispatchQueue.main.async {
                self.friendImage.imageView.image = UIImage(data: imageData)
            }
        }
        
    }
    
    @objc func setImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func bestFriend() {
        currentFriend.isBest!.toggle()
        FireStoreManager.shared.changeFriendsBestOrNot(best: currentFriend.isBest!, friend: currentFriend) { error in
            if error != nil {
                let alert = UIAlertController.showAlert(title: "Error", message: error!.localizedDescription)
                self.present(alert, animated: true)
            }
        }
        bestFriendButton.tintColor = currentFriend.isBest! ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        UserDefaults.standard.setValue(currentFriend.isBest!, forKey: currentFriend.fullName)
    }
    
    @objc func textViewEnable() {
        descriptionText.isEditable.toggle()
        buttonColor.toggle()
        changeTextButton.backgroundColor = buttonColor ?  #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    
    
        
    func textViewDidChange(_ textView: UITextView) {
        FireStoreManager.shared.changeFriendsDescription(friend: currentFriend, text: descriptionText.text) { error in
            if error != nil {
                let alert = UIAlertController.showAlert(title: "Error", message: error!.localizedDescription)
                self.present(alert, animated: true)
            }
        }
        currentFriend.description = descriptionText.text
    }
    
    
    func greate() {
        bestFriendButton.tintColor = currentFriend.isBest! ? #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.backgroundColor = .clear
        gradient.frame = self.view.bounds
        
        friendImage.translatesAutoresizingMaskIntoConstraints = false
        descriptionAboutFriend.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        changeTextButton.translatesAutoresizingMaskIntoConstraints = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        bestFriendButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.insertSublayer(gradient, at: 0)
        view.addSubview(friendImage)
        view.addSubview(descriptionAboutFriend)
        view.addSubview(changeTextButton)
        descriptionAboutFriend.addSubview(descriptionText)
        descriptionAboutFriend.addSubview(nameText)
        descriptionAboutFriend.addSubview(bestFriendButton)
        
        NSLayoutConstraint.activate([
            friendImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            friendImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionAboutFriend.topAnchor.constraint(equalTo: friendImage.bottomAnchor, constant: 20),
            descriptionAboutFriend.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionAboutFriend.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            descriptionAboutFriend.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.size.height)*0.12)
        ])
     
        NSLayoutConstraint.activate([
            changeTextButton.topAnchor.constraint(equalTo: descriptionAboutFriend.topAnchor, constant: 3),
            changeTextButton.trailingAnchor.constraint(equalTo: descriptionAboutFriend.trailingAnchor, constant: -3),
            changeTextButton.widthAnchor.constraint(equalToConstant: 34),
            changeTextButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: descriptionAboutFriend.topAnchor, constant: 50),
            descriptionText.leadingAnchor.constraint(equalTo: descriptionAboutFriend.leadingAnchor, constant: 5),
            descriptionText.trailingAnchor.constraint(equalTo: descriptionAboutFriend.trailingAnchor, constant: -5),
            
            descriptionText.bottomAnchor.constraint(equalTo: descriptionAboutFriend.bottomAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            nameText.topAnchor.constraint(equalTo: descriptionAboutFriend.topAnchor, constant: 5),
            nameText.leadingAnchor.constraint(equalTo: descriptionAboutFriend.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            bestFriendButton.leadingAnchor.constraint(equalTo: nameText.trailingAnchor, constant: 10),
            bestFriendButton.centerYAnchor.constraint(equalTo: nameText.centerYAnchor, constant: -5),
            bestFriendButton.widthAnchor.constraint(equalToConstant: 30),
            bestFriendButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}


extension InfoAboutFriendViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            FireBaseStorageManager.shared.uploadFriendPhoto(friend: currentFriend, image: image) { error in
                if let error = error {
                    let alert = UIAlertController.showAlert(title: "Error", message: error.localizedDescription)
                    self.present(alert, animated: true)
                }
            }
            friendImage.imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - SwiftUI for Canvas

import SwiftUI

struct InfoAboutFriendViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = InfoAboutFriendViewController(currentFriend: Friend(uid: "fcsc", name: "svfdv", lastName: "vdfvd"))
        
        func makeUIViewController(context: Context) -> InfoAboutFriendViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
    }
}

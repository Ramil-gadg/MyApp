//
//  MainViewController.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 17.09.2021.
//

import UIKit

class MainViewController: UIViewController{
    
    var currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        title = currentUser.name
    }
    
    
    var gradient: CAGradientLayer = {
      let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPink.cgColor, UIColor.blue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        return gradient
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var button: UIBarButtonItem {
      let button = UIBarButtonItem(title: "Выйти",
                                   style: .plain,
                                   target: self,
                                   action: #selector(logOut))
        button.tintColor = .red
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        gradient.frame = self.view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        navigationItem.rightBarButtonItem = button
        view.backgroundColor = UIColor.mainBackground()
    }
    @objc func logOut() {
        AuthManager.shared.signOut()
        
    }
}

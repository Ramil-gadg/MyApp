//
//  MainTabBarController.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 17.09.2021.
//

import UIKit



class MainTabBarController: UITabBarController {
    
    
    var currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBar.backgroundColor = .buttonBackground()
        let mainVC = MainViewController(currentUser: currentUser)
        let friendsVC = FriendsViewController(currentUser: currentUser)
        
        viewControllers = [
            generateNavigationController(rootViewController: mainVC, title: "Обо мне", image: UIImage(systemName: "person.crop.circle.fill")!),
            generateNavigationController(rootViewController: friendsVC, title: "Мои друзья", image: UIImage(systemName: "person.3.fill")!),
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}

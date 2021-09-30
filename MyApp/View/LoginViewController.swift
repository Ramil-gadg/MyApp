//
//  ViewController.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: LoginViewModelProtocol! 
    var registrationLoginVC = RegistrationViewController()
    
    let mainTitle = UILabel(text: "Мой дневник 📒", font: .titleFont(), textColor: .text())
    let labelForFirstTextField = UILabel(text: "Адрес электронной почты", font: .regularFont(), textColor: .text())
    let labelForSeconfTextField = UILabel(text: "Ваш пароль", font: .regularFont(), textColor: .text())
    
    let emailTextField = UITextField(placeholder: "Введите почту")
    let passwordTextField = UITextField(placeholder: "Введите пароль", isPassword: true)
    
    let enterButton = UIButton(title: "Войти", hasBackgroundColor: true)
    let loginButton = UIButton(title: "Регистрация", font: .regularFont(), hasBackgroundColor: false)
    
    let scrollView: UIScrollView = {
          let v = UIScrollView()
          return v
      }()
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        registrationLoginVC.delegate = self
        setConstrains ()
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        loginButton.addTarget(self, action: #selector(showRegistrationVC), for: .touchUpInside)
        enterButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
    }
    
    
    
    @objc func showRegistrationVC () {
        present(registrationLoginVC, animated: true)
    }
    @objc func signIn() {
        let email = emailTextField.text
        let password = passwordTextField.text
       
        viewModel = LoginViewModel(email: email, password: password)
        viewModel.signIn(email: email, password: password) {[weak self] user, error in
            if error != nil {
                let alert = UIAlertController.showAlert(title: "Error", message: error?.localizedDescription ?? "error")
                self?.present(alert, animated: true)
            }
            if user != nil {
                FireStoreManager.shared.getUserData(user: user!) { muser, error in
                    guard let muser = muser else {
                        let alert = UIAlertController.showAlert(title: "Ошибка", message: error?.localizedDescription ?? "ERROR")
                        self?.present(alert, animated: true)
                        return
                    }
                    let mainVC = MainTabBarController(currentUser: muser)
                    mainVC.modalPresentationStyle = .fullScreen
                    self?.show(mainVC, sender: nil)
                }
                
            } else {
                let alert = UIAlertController.showAlert(title: "Ошибка", message: "Такого пользователя не существует")
                self?.present(alert, animated: true)
            }
        }
    }
}

extension LoginViewController {
    private func setConstrains () {
        
        view.backgroundColor = .mainBackground()
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
        
        let emailStack = UIStackView(firstView: labelForFirstTextField, secondView: emailTextField, verticalSpacing: 10)
        let passwordStack = UIStackView(firstView: labelForSeconfTextField, secondView: passwordTextField, verticalSpacing: 10)
        let generalStack = UIStackView(firstView: emailStack, secondView: passwordStack, verticalSpacing: 20)
        
        generalStack.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainTitle)
        scrollView.addSubview(generalStack)
        scrollView.addSubview(enterButton)
        scrollView.addSubview(loginButton)
        
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            generalStack.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            generalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            enterButton.topAnchor.constraint(equalTo: generalStack.bottomAnchor, constant: 40),
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            enterButton.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}



extension LoginViewController: ShowMainVC {
    func toMainVC(muser: MUser) {
        let mainVC = MainViewController(currentUser: muser)
        mainVC.modalPresentationStyle = .fullScreen
        show(mainVC, sender: nil)
    }
}
    


extension LoginViewController {
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbFrameSize.height, right: 0.0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        UIView.animate(withDuration: 0.1) {
            self.scrollView.contentInset = UIEdgeInsets.zero
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



//MARK: - SwiftUI for Canvas

import SwiftUI

struct LoginViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> LoginViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
    }
}

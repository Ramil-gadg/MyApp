//
//  RegistrationViewController.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 15.09.2021.
//

import UIKit


protocol ShowMainVC: AnyObject{
    func toMainVC(muser: MUser)
}

class RegistrationViewController: UIViewController {
    
    var viewModel: RegistrationViewProtocol!
    weak var delegate: ShowMainVC?
    
    
    let scrollView: UIScrollView = {
          let v = UIScrollView()
          return v
      }()
    
    let mainTitle = UILabel(text: "Регистрация 🖐🏻", font: .titleFont(), textColor: .text())
    let labelForNameTextField = UILabel(text: "Ваше имя", font: .regularFont(), textColor: .text())
    let labelForLastNameTextField = UILabel(text: "Ваша фамилия", font: .regularFont(), textColor: .text())
    let labelForEmailTextField = UILabel(text: "Адрес электронной почты", font: .regularFont(), textColor: .text())
    let labelForPasswordTextField = UILabel(text: "Ваш пароль", font: .regularFont(), textColor: .text())
    let labelForRepeatPasswordTextField = UILabel(text: "Повторите пароль", font: .regularFont(), textColor: .text())
    
    let nameTextField = UITextField(placeholder: "Введите имя")
    let lastNameTextField = UITextField(placeholder: "Введите фамилию")
    let emailTextField = UITextField(placeholder: "Введите адрес электронной почты")
    let passwordTextField = UITextField(placeholder: "Введите пароль", isPassword: true)
    let repeatPasswordTextField = UITextField(placeholder: "Повторите пароль", isPassword: true)
    
    let registrationButton = UIButton(title: "Готово", hasBackgroundColor: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setConstrains ()
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        registrationButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }

    @objc func dismissVC () {
        guard let name = nameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let repeatPassword = repeatPasswordTextField.text, name != "", lastName != "", email != "", password != "", repeatPassword != "", password == repeatPassword else {
            let alert = UIAlertController.showAlert(title: "Заполните все данные", message: "Также убедитесь, что повторный пароль совпадает")
            present(alert, animated: true)
            return}
        
        viewModel = RegistrationViewModel(user: MUser(id: nil, name: name, lastName: lastName, email: email, password: password))
        viewModel.createUser(user: viewModel.muser) {[weak self] user, error in
            guard user != nil, error == nil else {
                let alert = UIAlertController.showAlert(title: "Error", message: error?.localizedDescription ?? "error")
                self?.present(alert, animated: true)
                return
            }
            FireStoreManager.shared.saveUserProfile(id: (user?.uid)!, name: name, lastName: lastName, email: email, password: password) { error in
                if let error = error {
                    let alert = UIAlertController.showAlert(title: "Error", message: error.localizedDescription)
                    self?.present(alert, animated: true)
                }
            }
            
            self?.dismiss(animated: true) { [weak self] in
                self?.delegate?.toMainVC(muser: (self!.viewModel.muser))
            }
        }
    }
}

extension RegistrationViewController {
    private func setConstrains () {
        
        view.backgroundColor = .mainBackground()
        
        let nameStack = UIStackView(firstView: labelForNameTextField, secondView: nameTextField, verticalSpacing: 5)
        let lastNameStack = UIStackView(firstView: labelForLastNameTextField, secondView: lastNameTextField, verticalSpacing: 5)
        let emailStack = UIStackView(firstView: labelForEmailTextField, secondView: emailTextField, verticalSpacing: 5)
        let passwordStack = UIStackView(firstView: labelForPasswordTextField, secondView: passwordTextField, verticalSpacing: 5)
        let repeatPasswordStack = UIStackView(firstView: labelForRepeatPasswordTextField, secondView: repeatPasswordTextField, verticalSpacing: 5)
        
        let generalStack = UIStackView(arrangedSubviews: [nameStack, lastNameStack, emailStack, passwordStack, repeatPasswordStack])
        generalStack.spacing = 8
        generalStack.axis = .vertical
        
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        generalStack.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainTitle)
        scrollView.addSubview(generalStack)
        scrollView.addSubview(registrationButton)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            generalStack.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            generalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registrationButton.topAnchor.constraint(equalTo: generalStack.bottomAnchor, constant: 30),
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            registrationButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}


extension RegistrationViewController {
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbFrameSize.height, right: 0.0)
        self.scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        self.scrollView.contentSize = .zero
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentInset = UIEdgeInsets.zero
        }
    }
}

//MARK: - SwiftUI for Canvas

import SwiftUI

struct RegistrationViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {

        let viewController = RegistrationViewController()
     
        func makeUIViewController(context: Context) -> RegistrationViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
    }
}

//
//  UIAlert + Extension.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 16.09.2021.
//


import UIKit


extension UIAlertController {
    
    static func showAlert (title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    static func showAlertWithTextField (title: String, message: String, completion:@escaping (UIAlertAction, String, String) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Имя друга"
            textField.layer.cornerRadius = 6
            
        }
        alert.addTextField { textField in
            textField.placeholder = "Фамилия друга"
            textField.layer.cornerRadius = 6
            
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { action in
            guard alert.textFields?[0].text != nil, alert.textFields?[0].text != "", alert.textFields?[1].text != nil, alert.textFields?[1].text != ""  else { return }
            let name = alert.textFields?[0].text
            let lastName = alert.textFields?[1].text
            completion(action, name!, lastName!)
        })
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))

        
        return alert
    }
}

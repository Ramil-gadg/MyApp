//
//  ThirdViewController.swift
//  delegate project
//
//  Created by Рамил Гаджиев on 22.09.2021.
//

import UIKit

class ThirdViewController: UIViewController {

//    var delegate: ViewControllerDelegate?
    var name: String = ""
    var lastName: String = ""
//    var text = ""
    func closure (completion: @escaping (String) -> ()){
     completion(name + lastName)
    }
    
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var lastNameLabel: UILabel!
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
 
        }
        
//        delegate?.saveFullName(fullName: "\(name) + \(lastName)")
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        text = "\(name) \(lastName)"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        lastNameLabel.text = lastName
       

    }
    

}

//
//  SecondViewController.swift
//  delegate project
//
//  Created by Рамил Гаджиев on 22.09.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    var name: String = ""

    @IBOutlet var lastNameTF: UITextField!
    
    @IBAction func show3VCButtonAction(_ sender: UIButton) {
        lastNameTF.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "to3VC" else {return}
        if let thirdVC = segue.destination as? ThirdViewController {
            if let lastName = lastNameTF.text, lastName != "" {
                thirdVC.lastName = lastName
                thirdVC.name = name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  delegate project
//
//  Created by Рамил Гаджиев on 22.09.2021.
//

import UIKit

//protocol ViewControllerDelegate {
//    func saveFullName(fullName: String)
//}

class ViewController: UIViewController {
    
    
    
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var nameTF: UITextField!
    @IBAction func show2VCButtonAction(_ sender: UIButton) {
        nameTF.text = ""
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "to2VC" else {return}
        if let secondVC = segue.destination as? SecondViewController {
            if let name = nameTF.text, name != "" {
                secondVC.name = name
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  guard let thirdVC = storyboard?.instantiateViewController(identifier: "third") as? ThirdViewController else { return}
//        thirdVC.delegate = self
    }
    
    
    @IBAction func saveData(unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? ThirdViewController else {return}
//        fullNameLabel.text = source.text
        source.closure { fullname in
            self.fullNameLabel.text = fullname
        }
        }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
//    func saveFullName(fullName: String) {
//        fullNameLabel.text = fullName
//    }
     
    }
   
    




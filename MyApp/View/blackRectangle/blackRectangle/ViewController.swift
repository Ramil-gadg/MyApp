//
//  ViewController.swift
//  blackRectangle
//
//  Created by Рамил Гаджиев on 24.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var fullView: UIView!
    @IBOutlet var myView: UIView!
    var counter = 0 {
        didSet {
            title = "\(counter)"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullView.backgroundColor = .gray
        fullView.addSubview(myView)
        title = "\(counter)"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        myView.addGestureRecognizer(tapGesture)
        print(fullView.frame.maxY, fullView.frame.minY, fullView.frame.height, fullView.frame.origin.y, view.frame.height)
    }
    
    @objc func didTap() {
        counter += 1
        let x: CGFloat = CGFloat.random(in: (myView.frame.width/2...fullView.frame.origin.y-myView.frame.width/2))
        let y: CGFloat = CGFloat.random(in: (myView.frame.height/2...fullView.frame.origin.y-myView.frame.height/2))
        
        UIView.animate(withDuration: 0.8, delay: 0) {
            self.myView.transform = CGAffineTransform(scaleX: 2, y: 2).translatedBy(x: 2, y: 100)
            self.myView.backgroundColor = .red
        } completion: { _ in
            self.myView.transform = .identity
        }
    }

            
//            self.myView.frame.origin.x = self.fullView.frame.width - 100
//            self.myView.frame.origin.y = self.fullView.frame.height - 100
           // self.myView.layer.position = CGPoint(x: , y: self.fullView.frame.maxY-self.myView.frame.height/2)
        }


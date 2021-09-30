//: [Previous](@previous)

import Foundation

 //Сообщить нескольким подписавшимся об изменении свойства


protocol Subject {
    func addChild(child: Children)
    func deleteChild(child: Children)
    func notify(string: String)
}


class Parent: Subject {
    var childs = NSMutableSet()
    var order: String = "" {
        didSet {
            notify(string: order)
        }
    }
    func addChild(child: Children) {
        childs.add(child)
    }
    func deleteChild(child: Children) {
        childs.remove(child)
    }
    func notify(string: String) {
        for child in childs {
            (child as! Children).getOrder(string: string)
        }
    }
}

protocol Children {
    var order: String { get }
    func getOrder(string: String)
}

class Child: NSObject, Children {
    
    var order: String = "" {
        didSet {
         print("look at new order")
        }
    }
    
    func getOrder(string: String) {
        order = string
    }
    
}

let parent = Parent()
let child = Child()
parent.addChild(child: child)

parent.order = "new home work"
child.order

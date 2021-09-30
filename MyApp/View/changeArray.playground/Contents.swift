import UIKit

var greeting = "Hello, playground"


var array = ["andora", "russia", "usa"]

var array1 = [String]()

for word in array {
    if !word.contains("a") {
        array1.append(word)
    } else {
        var newWord = ""
        for char in word {
            if char != "a" {
              newWord += String(char)
            } else {
                newWord += "b"
            }
        }
        array1.append(newWord)
    }
}

print (array1)


var name = "stas"

let na = name.map { $0.uppercased()}
print(na)

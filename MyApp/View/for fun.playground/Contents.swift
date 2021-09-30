import UIKit

//var array = [4, 5, 6, 3, 2, 0, 4]
//
//func removeDublicates(array: inout [Int]) -> Int {
//    var i = 0
//    var last: Int?
//
//    while i<array.count {
//        if array[i] == last {
//            last = array[i]
//            array.remove(at: i)
//        } else {
//            last = array[i]
//            i += 1
//        }
//    }
//    return array.count
//}
//var a = [0, 1, 4, 4, 4, 5, 6, 6, 6, 7]
//var r = removeDublicates(array: &a)
//
//print(r)
//print(a)

//----------------------

//func lookForSequence(array: [Int]) -> Int{
//    var min = array[array.count-1]
//    var max = array[0]
//    var start = 0
//    var end = 0
//    var i = 0
//    var j = array.count - 1
//
//    for _ in 1...array.count {
//
//        if array[i] >= max {
//            max = array[i]
//        } else {
//            end = i
//        }
//
//        if array[j] <= min {
//            min = array[j]
//
//        } else {
//            start = j
//        }
//        i += 1
//        j -= 1
//    }
//    var count = end - start + 1
//    if end == start {
//      count = 0
//    }
//    return count
//}
//
//var a = [ 1, 4, 4, 5, 6, 6, 6,0, 1]
//let z = lookForSequence(array: a)
//print(z)

//----------------------

//func reverseArray(array: inout [Character]) -> [Character] {
//    var index = array.count
//    for _ in array {
//        array.insert(array[0], at: index)
//        array.remove(at: 0)
//        index -= 1
//    }
//
//    return array
//}
//
//
//var s: [Character] = ["a", "b", "c", "d", "1", "2", "3", "4"]
//reverseArray(array: &s)
//print(s)

//-----------------------

func lessThanOneDifferent(first: String, second: String) -> Bool {
    var different = 0
    var ch1 = 0
    var ch2 = 0
    
    let charArray1:[Character] = first.map{$0}
    let charArray2:[Character] = second.map{$0}
    
    guard Range(-1...1).contains(charArray1.count - charArray2.count) else { return false }
        
    if charArray1.count == charArray2.count {
        for i in 0..<charArray1.count {
            if charArray1[i] != charArray2[i] {
                different += 1
            }
        }
    } else if charArray1.count > charArray2.count {
        while ch2 < charArray2.count, ch1 < charArray1.count {
            if charArray1[ch1] == charArray2[ch2]{
                ch1 += 1
                ch2 += 1
            } else {
                different += 1
                ch1 += 1
            }
        }
    } else if charArray1.count < charArray2.count{
        while ch1 < charArray1.count, ch2 < charArray2.count {
            if charArray1[ch1] == charArray2[ch2]{
                ch1 += 1
                ch2 += 1
            } else {
                different += 1
                ch2 += 1
            }
        }
    }
    if different > 1 {
        return false
    } else {
        return true
    }
}


let str1 = "sobah"
let str2 = "sobaha"

print(lessThanOneDifferent(first: str1, second: str2))

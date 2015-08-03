//: Playground - noun: a place where people can play

import UIKit

let exampleArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]

func reverseArray(array: Array<Int>) {
    var arrayCopy = array
    for var i = 0; i < array.count; i++ {
        var temp = array[i]
        arrayCopy[i] = array[array.count - i - 1];
        arrayCopy[array.count - i - 1] = temp;
        print(arrayCopy[i])
    }
}

reverseArray(exampleArray)
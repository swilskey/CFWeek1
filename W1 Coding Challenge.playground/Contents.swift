//: Playground - noun: a place where people can play

import UIKit


/*
* Monday
* Reverse Array Challenge
*
*/

let exampleArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]

func reverseArray(array: [Int]) {
    var arrayCopy = array
    for var i = 0; i < array.count; i++ {
        var temp = array[i]
        arrayCopy[i] = array[array.count - i - 1];
        arrayCopy[array.count - i - 1] = temp;
        
    }
    println(arrayCopy)
}

reverseArray(exampleArray)

/*
* Tuesday
* Fizz Buzz
*
*/

func fizzbuzz() {
    for i in 1...100 {
        if ((i % 3 == 0) && (i % 5 == 0)) {
            println("FizzBuzz")
        }
        else if (i % 3 == 0) {
            println("Fizz")
        }
        else if (i % 5 == 0) {
            println("Buzz")
        }
        else {
            println(i)
        }
    }
}

fizzbuzz()

/*
* Wednesday
* Number of Times Hi Appears in a String
*
*/

func hiCount(string: String) {
    
}

hiCount("hi this is hi")
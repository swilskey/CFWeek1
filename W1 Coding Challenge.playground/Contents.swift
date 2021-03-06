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

func hiCount(string: String, selection: String){
  
  var words = string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  var wordDictionary = [String: Int]()
  
  for word in words {
    if let count = wordDictionary[word] {
      wordDictionary[word] = count + 1
    } else {
      wordDictionary[word] = 1
    }
  }
  println("There are \(wordDictionary[selection]!) hi's in the string")
}

hiCount("hi this is hi", "hi")

/*
* Thursday
* Remove all 'x' from a String except if first character or last
*
*/

func removeX(string: String) {
  var stringCopy = ""
  var i = 0
  for char in string {
    if char == "x" {
      if i == 0 || i == count(string) {
        stringCopy.append(char)
        i++
      }
      i++
    } else {
      stringCopy.append(char)
      i++
    }
  }
  println(stringCopy)
}

removeX("xthixs isx testing x removal ax testx")

/*
* Thursday
* Impliment a Stack
*
*/

class MyQueue {
  
  private var queue = [Int]()
  
  func enqueue(add: Int) {
    queue.append(add)
  }
  
  func dequeue() -> Int {
    let item = queue[0]
    queue.removeAtIndex(0)
    return item
  }
  
}
let queue = MyQueue()
queue.enqueue(1)
queue.enqueue(4)
queue.enqueue(55)

queue.dequeue()

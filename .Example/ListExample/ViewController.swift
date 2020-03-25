//
//  ViewController.swift
//  ListExample
//
//  Created by Mohamed Afsar on 25/03/20.
//  Copyright © 2020 Jambav. All rights reserved.
//

import UIKit
import DoublyLinkedList

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let list = DoublyLinkedList<String>()
        
        let one = "one", two = "two", three = "three", four = "four", five = "five"
        list.append(one)
        
        
        // Count
        print("list.count: \(list.count)")
        print("list.isEmpty: \(list.isEmpty)")
        
        // Remove
        print("list.remove(at: 0): \(list.remove(at: 0))")
        print("list.count: \(list.count)")
        print("list.isEmpty: \(list.isEmpty)")
        
        // Append
        list.append([one, two, three, four, five])
        print("list.count: \(list.count)")
        print("list.isEmpty: \(list.isEmpty)")
        
       // Insert
        let zero = "zero"
        print("list.insert(zero, at: 0): \(list.insert(zero, at: 0))")
        
        let six = "six"
        print("list.insert(six, at: 10): \(list.insert(six, at: 10))")
        print("list.insert(six, at: 6): \(list.insert(six, at: 6))")
        
        let twoPointOne = "two.one"
        print("list.insert(twoPointOne, at: 2): \(list.insert(twoPointOne, at: 2))")
        print("1.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
        print("list.count: \(list.count)")
        
        // Index
        print("list.index(twoPointOne): \(String(describing: list.index(twoPointOne)))")
        print("list.index(zero): \(String(describing: list.index(zero)))")
        print("list.index(\"minusOne\"): \(String(describing: list.index("minusOne")))")
        
        // Remove
        print(list.remove(at: 2), true)
        print(list.count, 7)
        
        print(list.remove(at: 7), false)
        print(list.remove(at: 6), true)
        print("2.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
        
        // Find
        print("list.find(at: 3)?.key: \(String(describing: list.find(at: 3)))")
        print("list.find(at: 0)?.key: \(String(describing: list.find(at: 0)))")
        print("list[5]?.key: \(String(describing: list[5]))")
        
        print("list[6]?.key: \(String(describing: list[6]))")
        
        // Append
        list.append("six")
        print("list.count: \(list.count)")
        print("3.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
        
        // RemoveAll
        list.removeAll()
        print(list.count, 0)
        print("4.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
    }
}


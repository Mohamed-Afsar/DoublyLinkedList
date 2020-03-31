//
//  Listable.swift
//  DoublyLinkedList
//
//  Created by Mohamed Afsar on 26/03/20.
//  Copyright © 2020 Mohamed Afsar. All rights reserved.
//

import Foundation

public protocol Listable {
    // Types
    associatedtype E
    
    // Variables
    var first: E? { get } // First element
    var count: Int { get } // Items count
    var isEmpty: Bool { get } // Empty state
    
    // Functions
    func append(_ key: E) // Append an element
    func insert(_ key: E, at idx: Int) // Insert an element
    func remove(at idx: Int) // Remove element from given index
    func remove(_ key: E) // Removes given element
    func index(_ key: E) -> Int? // Index of given element
    func find(at idx: Int) -> E? // Element from given index
    func forEach(reversed: Bool, _ body: ((E) -> Void)) // Iteration
    func enumerateObjects(reversed: Bool, _ body: ((_ obj: E, _ idx: Int, _ stop: inout Bool) -> Void))  // Iteration
}

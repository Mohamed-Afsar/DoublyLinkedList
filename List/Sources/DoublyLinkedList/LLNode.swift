//
//  LLNode.swift
//  DoublyLinkedList
//
//  Created by Mohamed Afsar on 24/03/20.
//  Copyright © 2020 Mohamed Afsar. All rights reserved.
//

internal final class LLNode<T> {
    internal var key: T?
    internal var previous: LLNode?
    internal var next: LLNode?
    
    func reset() {
        self.key = nil
        self.previous = nil
        self.next = nil
    }
}

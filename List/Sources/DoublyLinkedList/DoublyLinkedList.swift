//
//  DoublyLinkedList.swift
//  DoublyLinkedList
//
//  Created by Mohamed Afsar on 24/03/20.
//  Copyright © 2020 Mohamed Afsar. All rights reserved.
//

// Reference: https://medium.com/swift-algorithms-data-structures/building-linked-lists-with-swift-1812c747dad3

public final class DoublyLinkedList<T: Equatable> {
    // MARK: Public IVars
    public var count: UInt {
        return counter
    }
    public var isEmpty: Bool {
        return self.counter == 0
    }
    
    // MARK: Private IVars
    private var head = LLNode<T>()
    private var counter: UInt = 0

    // MARK: Initialization
    public init() { }
    
    public init(_ key: T) {
        self.append(key)
    }
    
    public init(_ keys: [T]) {
        self.append(keys)
    }
    
    // MARK: Deinitialization
    deinit {
        self.removeAll()
    }
}

// MARK: Public Functions
public extension DoublyLinkedList {
    func append(_ keys: [T]) {
        keys.forEach { self.append($0) }
    }
    
    func append(_ key: T) {
        self.counter += 1
        guard self.head.key != nil else {
            self.head.key = key
            return
        }
        var current: LLNode? = self.head
        while current != nil {
            if current!.next == nil {
                let childToUse = LLNode<T>()
                childToUse.key = key
                childToUse.previous = current
                current!.next = childToUse
                break
            }
            else {
                current = current?.next
            }
        }
    }
    
    @discardableResult
    func insert(_ key: T, at idx: UInt) -> Bool {
        guard idx >= 0 && idx <= self.counter else {
            return false
        }
        self.counter += 1
        var trailer: LLNode<T>?
        var current: LLNode<T>? = self.head
        var listIndex: UInt = 0
        
        let newNode = LLNode<T>()
        newNode.key = key
        
        // Determine if the insertion is at the head
        guard idx > listIndex else {
            newNode.next = current
            current?.previous = newNode
            self.head = newNode
            return true
        }
        
        while current != nil {
            if idx == listIndex {
                trailer!.next = newNode
                newNode.previous = trailer
                newNode.next = current
                current!.previous = newNode
                return true
            }
            // Update assignments
            trailer = current
            current = current!.next
            listIndex += 1
        }
        newNode.previous = trailer!
        trailer!.next = newNode
        return true
    }
    
    func index(_ key: T) -> UInt? {
        var current: LLNode<T>? = self.head
        var idx: UInt = 0
        while current != nil {
            if key == current!.key {
                return idx
            }
            current = current!.next
            idx += 1
        }
        return nil
    }
    
    func removeAll() {
        self.counter = 0
        var current: LLNode<T>? = self.head
        while current != nil {
            let item = current
            current = item!.next
            item!.reset()
        }
    }
    
    @discardableResult
    func remove(at idx: UInt) -> Bool {
        // Index conditions
        guard idx >= 0 && idx <= (self.counter - 1) else {
            return false
        }
        self.counter -= 1
        var trailer: LLNode<T>?
        var current: LLNode<T>? = self.head
        var listIndex: UInt = 0
        
        // Determine if the removal is at the head
        guard idx > listIndex else {
            if let next = current?.next {
                self.head = next
            }
            else {
                self.head.key = nil
            }
            return true
        }
        // Iterate through remaining items
        while current != nil {
            if listIndex == idx {
                // Redirect the trailer and next pointers
                let nextItem = current!.next
                current!.reset()
                trailer!.next = nextItem
                nextItem?.previous = trailer!
                break
            }
            // Update assignments
            trailer = current
            current = current?.next
            listIndex += 1
        }
        return true
    }
    
    subscript(idx: UInt) -> T? {
       get {
          return find(at: idx)
       }
    }
    
    func find(at idx: UInt) -> T? {
        guard idx >= 0 && idx <= (self.counter - 1) else {
            return nil
        }
        var current: LLNode<T> = self.head
        var i: UInt = 0 // Cycle through elements
        while (idx != i) {
            current = current.next!
            i += 1
        }
        return current.key
    }
    
    func printAllKeys(reversed: Bool = false) {
        var trail: LLNode<T>?
        var current: LLNode? = self.head
        while current != nil {
            if !reversed {
                print("Link item is: \(String(describing: current!.key))")
            }
            trail = current
            current = current!.next
        }
        
        if reversed {
            print("REVERSED:")
            while trail != nil {
                print("Link item is: \(String(describing: trail!.key))")
                trail = trail!.previous
            }
        }
    }
}

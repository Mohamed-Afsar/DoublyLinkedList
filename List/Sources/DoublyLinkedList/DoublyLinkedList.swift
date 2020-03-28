//
//  DoublyLinkedList.swift
//  DoublyLinkedList
//
//  Created by Mohamed Afsar on 24/03/20.
//  Copyright © 2020 Mohamed Afsar. All rights reserved.
//

open class DoublyLinkedList<T: Equatable>: Listable, ExpressibleByArrayLiteral {
    // MARK: Public IVars
    public var first: T? { return self.head.element }
    public var last: T? { return self.tail.element }
    public var count: Int { return counter }
    public var isEmpty: Bool { return self.counter == 0 }
    
    // MARK: Private IVars
    private var head = LLNode<T>()
    private var tail: LLNode<T>
    private var counter: Int = 0

    // MARK: Initialization
    required public init() {
        self.tail = self.head
    }
    
    required public convenience init(arrayLiteral elements: T...) {
        self.init()
        self.append(elements)
    }
    
    public convenience init(_ element: T) {
        self.init()
        self.append(element)
    }
    
    public convenience init(_ elements: [T]) {
        self.init()
        self.append(elements)
    }
    
    // MARK: Open Manipulating Functions
    open func append(_ elements: [T]) {
        elements.forEach { self.append($0) }
    }
    
    open func append(_ element: T) {
        self.counter += 1
        let newNode = LLNode<T>()
        newNode.element = element
        if let _ = self.tail.element {
            newNode.previous = self.tail
            self.tail.next = newNode
            self.tail = newNode
        }
        else {
            self.head = newNode
            self.tail = self.head
        }
    }
    
    open func prepend(_ elements: [T]) {
        elements.forEach { self.prepend($0) }
    }
    
    open func prepend(_ element: T) {
        self.counter += 1
        let newNode = LLNode<T>()
        newNode.element = element
        if let _ = self.head.element {
            newNode.next = self.head
            self.head.previous = newNode
            self.head = newNode
        }
        else {
            self.head = newNode
            self.tail = self.head
        }
    }
    
    @discardableResult
    open func insert(_ element: T, at idx: Int) -> Bool {
        guard idx >= 0 && idx <= self.counter else {
            return false
        }
        guard idx > 0 else {
            self.prepend(element)
            return true
        }
        guard idx < self.counter else {
            self.append(element)
            return true
        }
        
        self.counter += 1
        var current: LLNode<T>? = self.head.next
        var listIndex: Int = 1
        while current != nil {
            if idx == listIndex {
                let newNode = LLNode<T>()
                newNode.element = element
                let leading = current!.previous
                leading?.next = newNode
                newNode.previous = leading
                newNode.next = current
                current!.previous = newNode
                break
            }
            current = current!.next
            listIndex += 1
        }
        return true
    }
        
    open func removeAll() {
        self.counter = 0
        var current: LLNode<T>? = self.head
        while current != nil {
            let item = current
            current = item!.next
            item!.reset()
        }
        self.tail = self.head
    }
    
    @discardableResult
    open func removeFirst() -> Bool {
        guard self.counter > 0 else { return false }
        self.counter -= 1
        if let next = self.head.next {
            self.head.reset()
            self.head = next
            self.head.previous = nil
        }
        else {
            self.head.reset()
        }
        return true
    }
    
    @discardableResult
    open func removeLast() -> Bool {
        guard self.counter > 0 else { return false }
        self.counter -= 1
        if let previous = self.tail.previous {
            self.tail.reset()
            self.tail = previous
            self.tail.next = nil
        }
        else {
            self.tail.reset()
        }
        return true
    }
    
    @discardableResult
    public func remove(_ element: T) -> Bool {
        guard self.counter > 0 else {
            return false
        }
        guard self.head.element != element else {
            return self.removeFirst()
        }
        
        var current: LLNode<T>? = self.head.next
        var listIndex: Int = 1
        while current != nil {
            if listIndex == (self.count - 1), current!.element == element {
                return self.removeLast()
            }
            else {
                if current!.element == element {
                    self.counter -= 1
                    let leading = current!.previous
                    let trailing = current!.next
                    current!.reset()
                    leading?.next = trailing
                    trailing?.previous = leading
                    return true
                }
                current = current!.next
                listIndex += 1
            }
        }
        return false
    }
    
    @discardableResult
    open func remove(at idx: Int) -> Bool {
        // Index conditions
        guard idx >= 0 && idx <= (self.counter - 1) else {
            return false
        }
        guard idx > 0 else {
            return self.removeFirst()
        }
        guard idx < (self.counter - 1) else {
            return self.removeLast()
        }
        
        self.counter -= 1
        var current: LLNode<T>? = self.head.next
        var listIndex: Int = 1
        while current != nil {
            if listIndex == idx {
                let leading = current!.previous
                let trailing = current!.next
                current!.reset()
                leading?.next = trailing
                trailing?.previous = leading
                break
            }
            current = current!.next
            listIndex += 1
        }
        return true
    }
    
    // MARK: Open Reading Functions
    open func index(_ element: T) -> Int? {
        var current: LLNode<T>? = self.head
        var idx: Int = 0
        while current != nil {
            if element == current!.element {
                return idx
            }
            current = current!.next
            idx += 1
        }
        return nil
    }
    
    open subscript(idx: Int) -> T? {
       get { return find(at: idx) }
    }
    
    open func find(at idx: Int) -> T? {
        guard idx >= 0 && idx <= (self.counter - 1) else {
            return nil
        }
        var current: LLNode<T> = self.head
        var i: Int = 0
        while (idx != i) {
            current = current.next!
            i += 1
        }
        return current.element
    }
    
    open func forEach(reversed: Bool = false, _ body: ((T) -> Void)) {
        if reversed {
            var current: LLNode? = self.tail
            while let val = current?.element {
                body(val)
                current = current!.previous
            }
        }
        else {
            var current: LLNode? = self.head
            while let val = current?.element {
                body(val)
                current = current!.next
            }
        }
    }
    
    open func enumerateObjects(reversed: Bool = false, _ body: ((_ obj: T, _ idx: Int, _ stop: inout Bool) -> Void)) {
        var stop = false
        if reversed {
            var idx = self.counter - 1
            var current: LLNode? = self.tail
            while let val = current?.element, !stop {
                body(val, idx, &stop)
                current = current!.previous
                idx -= 1
            }
        }
        else {
            var idx = 0
            var current: LLNode? = self.head
            while let val = current?.element, !stop {
                body(val, idx, &stop)
                current = current!.next
                idx += 1
            }
        }
    }

    open func printAllKeys(reversed: Bool = false) {
        if reversed {
            var current: LLNode? = self.tail
            while current != nil {
                print("Link item is: \(String(describing: current!.element))")
                current = current!.previous
            }
        }
        else {
            var current: LLNode? = self.head
            while current != nil {
                print("Link item is: \(String(describing: current!.element))")
                current = current!.next
            }
        }
    }
    
    // MARK: Deinitialization
    deinit {
        self.removeAll()
    }
}

extension DoublyLinkedList : CustomStringConvertible {
    public var description: String {
        let separator = ", "
        var desc = "[ "
        self.forEach { desc += String(describing: $0) + separator }
        let range = desc.index(desc.endIndex, offsetBy: -2)..<desc.endIndex
        desc = desc.replacingOccurrences(of: separator, with: "", range: range)
        desc += " ]"
        return desc
    }
}

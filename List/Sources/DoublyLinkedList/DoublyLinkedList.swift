//
//  DoublyLinkedList.swift
//  DoublyLinkedList
//
//  Created by Mohamed Afsar on 24/03/20.
//  Copyright © 2020 Mohamed Afsar. All rights reserved.
//

open class DoublyLinkedList<T: Equatable>: Listable, ExpressibleByArrayLiteral, CustomStringConvertible {
    // MARK: Open IVars
    open var first: T? { return self.head.element }
    open var last: T? { return self.tail.element }
    open var count: Int { return counter }
    open var isEmpty: Bool { return self.counter == 0 }
    
    // CustomStringConvertible Conformance
    open var description: String {
        return self._description()
    }
    
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
        self._append(elements)
    }
    
    public convenience init(_ element: T) {
        self.init()
        self._append(element)
    }
    
    public convenience init(_ elements: [T]) {
        self.init()
        self._append(elements)
    }
    
    // MARK: Open Manipulating Functions
    open func append(_ elements: [T]) {
        self._append(elements)
    }
    
    open func append(_ element: T) {
        self._append(element)
    }
    
    open func prepend(_ elements: [T]) {
        self._prepend(elements)
    }
    
    open func prepend(_ element: T) {
        self._prepend(element)
    }
    
    open func insert(_ element: T, at idx: Int) {
        self._insert(element, at: idx)
    }
        
    open func removeAll() {
        self._removeAll()
    }
    
    open func removeFirst() {
        self._removeFirst()
    }
    
    open func removeLast() {
        self._removeLast()
    }
    
    open func remove(_ element: T) {
        self._remove(element)
    }
    
    open func remove(at idx: Int) {
        self._remove(at: idx)
    }
    
    // MARK: Open Reading Functions
    open func index(_ element: T) -> Int? {
        self._index(element)
    }
    
    open subscript(idx: Int) -> T? {
        get {
            return self._getSubscript(idx: idx)
        }
        set {
            guard let newValue = newValue else { return }
            self._setSubscript(idx, newValue)
        }
    }
    
    open func find(at idx: Int) -> T? {
        self._find(at: idx)
    }
    
    open func forEach(reversed: Bool = false, _ body: ((T) -> Void)) {
        self._forEach(reversed: reversed, body)
    }
    
    open func enumerateObjects(reversed: Bool = false, _ body: ((_ obj: T, _ idx: Int, _ stop: inout Bool) -> Void)) {
        self._enumerateObjects(reversed: reversed, body)
    }

    open func printAllKeys(reversed: Bool = false) {
        self._printAllKeys(reversed: reversed)
    }
    
    // MARK: Deinitialization
    deinit {
        self._removeAll()
    }
}

// MARK: Helper Functions
private extension DoublyLinkedList {
    func _append(_ elements: [T]) {
        elements.forEach { self._append($0) }
    }
    
    func _append(_ element: T) {
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
    
    func _prepend(_ elements: [T]) {
        elements.forEach { self._prepend($0) }
    }
    
    func _prepend(_ element: T) {
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
    
    func _insert(_ element: T, at idx: Int) {
        guard idx >= 0 && idx <= self.counter else { return }
        guard idx > 0 else {
            self._prepend(element)
            return
        }
        guard idx < self.counter else {
            self._append(element)
            return
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
    }
    
    func _removeAll() {
        self.counter = 0
        var current: LLNode<T>? = self.head
        while current != nil {
            let item = current
            current = item!.next
            item!.reset()
        }
        self.tail = self.head
    }
    
    func _removeFirst() {
        guard self.counter > 0 else { return }
        self.counter -= 1
        if let next = self.head.next {
            self.head.reset()
            self.head = next
            self.head.previous = nil
        }
        else {
            self.head.reset()
        }
    }
    
    func _removeLast() {
        guard self.counter > 0 else { return }
        self.counter -= 1
        if let previous = self.tail.previous {
            self.tail.reset()
            self.tail = previous
            self.tail.next = nil
        }
        else {
            self.tail.reset()
        }
    }
    
    func _remove(_ element: T) {
        guard self.counter > 0 else { return }
        guard self.head.element != element else {
            self._removeFirst()
            return
        }
        var current: LLNode<T>? = self.head.next
        var listIndex: Int = 1
        while current != nil {
            if listIndex == (self.counter - 1), current!.element == element {
                self._removeLast()
                return
            }
            else {
                if current!.element == element {
                    self.counter -= 1
                    let leading = current!.previous
                    let trailing = current!.next
                    current!.reset()
                    leading?.next = trailing
                    trailing?.previous = leading
                }
                current = current!.next
                listIndex += 1
            }
        }
    }
    
    func _remove(at idx: Int) {
        // Index conditions
        guard idx >= 0 && idx <= (self.counter - 1) else {
            return
        }
        guard idx > 0 else {
            self._removeFirst()
            return
        }
        guard idx < (self.counter - 1) else {
            self._removeLast()
            return
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
    }
    
    func _index(_ element: T) -> Int? {
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
    
    func _getSubscript(idx: Int) -> T? {
        return self._find(at: idx)
    }
    
    func _setSubscript(_ idx: Int, _ element: T) {
        self._insert(element, at: idx)
    }
    
    func _find(at idx: Int) -> T? {
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
    
    func _forEach(reversed: Bool, _ body: ((T) -> Void)) {
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
    
    func _enumerateObjects(reversed: Bool, _ body: ((_ obj: T, _ idx: Int, _ stop: inout Bool) -> Void)) {
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
    
    func _printAllKeys(reversed: Bool) {
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
    
    func _description() -> String {
        let separator = ", "
        var desc = "[ "
        self._forEach(reversed: false) { desc += String(describing: $0) + separator }
        let range = desc.index(desc.endIndex, offsetBy: -2)..<desc.endIndex
        desc = desc.replacingOccurrences(of: separator, with: "", range: range)
        desc += " ]"
        return desc
    }
}

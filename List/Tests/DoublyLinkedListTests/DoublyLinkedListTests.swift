import XCTest
@testable import DoublyLinkedList

final class DoublyLinkedListTests: XCTestCase {
    
    func testExample() {
        let list = DoublyLinkedList<String>()
        XCTAssertEqual(list.count, 0)
        XCTAssertEqual(list.isEmpty, true)
        
        let one = "one", two = "two", three = "three", four = "four", five = "five"
        list.append(one)
        
        // Count
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.isEmpty, false)
        
        // Remove
        XCTAssertEqual(list.remove(at: 0), true)
        XCTAssertEqual(list.count, 0)
        XCTAssertEqual(list.isEmpty, true)
        
        // Append
        list.append([one, two, three, four, five])
        XCTAssertEqual(list.count, 5)
        XCTAssertEqual(list.isEmpty, false)
        
       // Insert
        let zero = "zero"
        XCTAssertEqual(list.insert(zero, at: 0), true)
        
        let six = "six"
        XCTAssertEqual(list.insert(six, at: 10), false)
        XCTAssertEqual(list.insert(six, at: 6), true)
        
        let twoPointOne = "two.one"
        XCTAssertEqual(list.insert(twoPointOne, at: 2), true)
        print("1.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
        XCTAssertEqual(list.count, 8)
        
        // Index
        XCTAssertEqual(list.index(twoPointOne), 2)
        XCTAssertEqual(list.index(zero), 0)
        XCTAssertEqual(list.index("minusOne"), nil)
        
        // Remove
        XCTAssertEqual(list.remove(at: 2), true)
        XCTAssertEqual(list.count, 7)
        
        XCTAssertEqual(list.remove(at: 7), false)
        XCTAssertEqual(list.remove(at: 6), true)
        print("2.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
        
        // Find
        XCTAssertEqual(list.find(at: 3), "three")
        XCTAssertEqual(list.find(at: 0), "zero")
        XCTAssertEqual(list[5], "five")
        
        XCTAssertEqual(list[6], nil)
        
        // Append
        list.append("six")
        XCTAssertEqual(list.count, 7)
        print("3.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
        
        // RemoveAll
        list.removeAll()
        XCTAssertEqual(list.count, 0)
        print("4.")
        list.printAllKeys()
        list.printAllKeys(reversed: true)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}


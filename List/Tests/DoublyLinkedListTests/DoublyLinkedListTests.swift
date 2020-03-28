import XCTest
@testable import DoublyLinkedList

final class DoublyLinkedListTests: XCTestCase {
    // MARK: Internal Class
    final class TestDeinit: Equatable {
        var name: String?
        var onDeInit:(() -> Void)?
        
        static func == (lhs: DoublyLinkedListTests.TestDeinit, rhs: DoublyLinkedListTests.TestDeinit) -> Bool {
            return lhs.name == rhs.name
        }
        
        deinit {
            self.onDeInit?()
        }
    }
    
    // MARK: IVars
    var tdObjs:DoublyLinkedList<TestDeinit>? = DoublyLinkedList<TestDeinit>()
    
    // MARK: Tests
    func testExample() {
        let list = DoublyLinkedList<String>()
        XCTAssertEqual(list.count, 0)
        XCTAssertEqual(list.isEmpty, true)
        let minusOne = "minusOne", zero = "zero", one = "one", two = "two", three = "three", four = "four", five = "five", six = "six"
        
        // Append
        list.append(one)
        
        // Count
        XCTAssertEqual(list.count, 1)
        
        // Empty
        XCTAssertEqual(list.isEmpty, false)
        
        // First - Last
        XCTAssertEqual(list.first, one)
        XCTAssertEqual(list.last, one)
        
        // RemoveFirst - RemoveLast
        XCTAssertEqual(list.removeFirst(), true)
        XCTAssertEqual(list.removeLast(), false)
        XCTAssertEqual(list.count, 0)
        
        // Append
        list.append([one, two, three])
        
        // Remove
        XCTAssertEqual(list.remove(at: 1), true)
        XCTAssertEqual(list.first, one)
        XCTAssertEqual(list.last, three)
        XCTAssertEqual(list.count, 2)
        
        XCTAssertEqual(list.remove(at: 0), true)
        XCTAssertEqual(list.remove(at: 0), true)
        XCTAssertEqual(list.count, 0)
        XCTAssertEqual(list.isEmpty, true)
        
        // RemoveAll
        list.removeAll()

        // Append
        list.append([one, two, three])
        XCTAssertEqual(list.removeLast(), true)
        XCTAssertEqual(list.removeLast(), true)
        XCTAssertEqual(list.removeLast(), true)
        XCTAssertEqual(list.removeLast(), false)
        XCTAssertEqual(list.count, 0)
        
        // First - Last
        XCTAssertEqual(list.first, nil)
        XCTAssertEqual(list.last, nil)
        XCTAssertEqual(list[2], nil)
        
        // Append
        list.append([one, two, three, four, five])
        XCTAssertEqual(list.count, 5)
        XCTAssertEqual(list.isEmpty, false)
        
       // Insert
        XCTAssertEqual(list.insert(zero, at: 0), true)
        
        XCTAssertEqual(list.insert(six, at: 10), false)
        XCTAssertEqual(list.insert(six, at: 6), true)
        
        let twoPointOne = "two.one"
        XCTAssertEqual(list.insert(twoPointOne, at: 2), true)
        print("1.")
        list.printAllKeys()
        print("Reversed")
        list.printAllKeys(reversed: true)
        XCTAssertEqual(list.count, 8)
        
        // Index
        XCTAssertEqual(list.index(twoPointOne), 2)
        XCTAssertEqual(list.index(zero), 0)
        XCTAssertEqual(list.index(minusOne), nil)
        
        // Remove
        XCTAssertEqual(list.remove(at: 2), true)
        XCTAssertEqual(list.count, 7)
        
        XCTAssertEqual(list.remove(at: 7), false)
        XCTAssertEqual(list.remove(at: 6), true)
        print("2.")
        list.printAllKeys()
        print("Reversed")
        list.printAllKeys(reversed: true)
        
        // Find
        XCTAssertEqual(list.find(at: 3), three)
        XCTAssertEqual(list.find(at: 0), zero)
        XCTAssertEqual(list[5], five)
        
        XCTAssertEqual(list[6], nil)
        
        // Append
        list.append(six)
        XCTAssertEqual(list.count, 7)
        print("3.")
        list.printAllKeys()
        print("Reversed")
        list.printAllKeys(reversed: true)
        
        // ForEach
        print("ForEach:")
        list.forEach { print("$0: \($0)") }
        print("ForEach: REVERSED")
        list.forEach(reversed: true) { print("$0: \($0)") }
        
        // EnumerateObjects
        print("EnumerateObjects:")
        list.enumerateObjects { (obj, idx, stop) in
            print("obj: \(obj); idx: \(idx); stop: \(stop)")
            if idx == 2 {
                XCTAssertEqual(obj, two)
            }
            if idx == 3 { stop = true }
        }
        print("EnumerateObjects: REVERSED")
        list.enumerateObjects(reversed: true) { (obj, idx, stop) in
            print("obj: \(obj); idx: \(idx); stop: \(stop)")
            if idx == 2 {
                XCTAssertEqual(obj, two)
            }
            if idx == 3 { stop = true }
        }
        
        // Prepend
        list.prepend(minusOne)
        XCTAssertEqual(list[0], minusOne)
        XCTAssertEqual(list[1], zero)
        XCTAssertEqual(list[7], six)
        
        list.printAllKeys()
        
        // RemoveObj
        XCTAssertEqual(list.remove(minusOne), true)
        XCTAssertEqual(list.remove("Hello"), false)
        XCTAssertEqual(list[0], zero)
        XCTAssertEqual(list[6], six)
        XCTAssertEqual(list.remove(six), true)
        XCTAssertEqual(list.count, 6)
        
        // RemoveAll
        list.removeAll()
        XCTAssertEqual(list.count, 0)
        print("4.")
        list.printAllKeys()
        print("Reversed")
        list.printAllKeys(reversed: true)
        
        // ----------
        
        let list2 = DoublyLinkedList<String>(["A", "B", "C"])
        let list3: DoublyLinkedList<String> = ["X", "Y", "Z"]
        print("list2: \(list2)")
        print("list3: \(list3)")
    }

    func testDeinit() {
        let expec1 = expectation(description: "o1 deinit")
        let expec2 = expectation(description: "o2 deinit")
        let expec3 = expectation(description: "o3 deinit")
        let expec4 = expectation(description: "o4 deinit")
        let expec5 = expectation(description: "o5 deinit")
        let expec6 = expectation(description: "o6 deinit")
        
        var o1: TestDeinit? = TestDeinit(), o2: TestDeinit? = TestDeinit(), o3: TestDeinit? = TestDeinit(), o4: TestDeinit? = TestDeinit(), o5: TestDeinit? = TestDeinit(), o6: TestDeinit? = TestDeinit()
        o1!.name = "One"; o2!.name = "Two"; o3!.name = "Three"; o4!.name = "Four"; o5!.name = "Five"; o6!.name = "Six"
        self.tdObjs?.append([o1!, o2!, o3!, o4!])
        
        o1!.onDeInit = { expec1.fulfill() }
        o2!.onDeInit = { expec2.fulfill() }
        o3!.onDeInit = { expec3.fulfill() }
        o4!.onDeInit = { expec4.fulfill() }
        o5!.onDeInit = { expec5.fulfill() }
        o6!.onDeInit = { expec6.fulfill() }
        
        o1 = nil; o3 = nil; o4 = nil;
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tdObjs?.remove(at: 2)
            self.tdObjs?.removeFirst()
            self.tdObjs?.removeLast()
            self.tdObjs?.remove(o2!)
            o2 = nil
            self.wait(for: [expec1, expec2, expec3, expec4], timeout: 1)
            
            self.tdObjs?.prepend(o5!)
            o5 = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tdObjs?.removeAll()
                self.wait(for: [expec5], timeout: 1)
                
                self.tdObjs?.append([o6!])
                o6 = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.tdObjs = nil
                }
            }
        }
        self.wait(for: [expec6], timeout: 4)
    }
    
    static var allTests = [
        ("testExample", testExample), ("testDeinit", testDeinit),
    ]
}


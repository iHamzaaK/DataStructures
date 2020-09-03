import UIKit

class Node<T> : CustomStringConvertible, Equatable{
    
    
    var value: T
    var next: Node?
    
    
    var description: String{
        guard let next = next else { return "\(value)"}
        return "\(value) -> " + String.init(describing: next)
    }
    init(_ value : T , _ next : Node? = nil) {
        self.value = value
        self.next = next
    }
    
    static func ==(lhs: Node , rhs: Node)->Bool{
        return lhs.next == rhs.next
    }
    
}

struct LinkedList<T> : CustomStringConvertible{
    
    var head : Node<T>?
    var tail : Node<T>?
    init(){}
    
    var isEmpty : Bool{
        return head == nil
    }
    var description: String{
        guard let head = head else { return "Empty List"}
        return String(describing: head)
    }
    
    mutating func push(_ value: T) {
        
        let newNode = Node(value, head)
        
        head = newNode
        
        if tail == nil {
            tail = head
        }
    }
    mutating func append(_ value : T){
        if isEmpty{
            self.push(value)
            return
        }
        tail?.next = Node(value)
        tail = tail?.next
    }
    func node(at index: Int)->Node<T>?{
        if isEmpty{return nil}
        var currentNode = head
        var currentIndex = 0
        while currentNode == nil && currentIndex < index{
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    func count()-> Int{
        var currentNode = head
        var count = 0
        while currentNode != nil{
            currentNode = currentNode?.next
            count += 1
        }
         return count
    }
    mutating func insertAt(after index : Int, value : T){
        if index < 0 || index > self.count(){
            self.append(value)
            return
        }
        if let beforeNode = self.node(at: index), let tail = tail{
            if beforeNode == tail{
                self.append(value)
                return
            }
            else {
                beforeNode.next = Node(value, beforeNode.next)
            }
        }
        else{
            self.push(value)
        }
    }
    @discardableResult
    mutating func pop()->T?{
        defer{
            head = head?.next
            if isEmpty{
                tail = nil
            }
        }
        return head?.value
        
    }
    @discardableResult
    mutating func deleteLast()->T?{
        //check if list is empty
        guard let head = head else { return nil}
        //check if head is only element
        guard head.next != nil else { return pop()}
        
        var currentNode = head
        var previousNode = head
        while let next = currentNode.next{
            previousNode = currentNode
            currentNode = next
        }
        previousNode.next = nil
        tail = previousNode
        return currentNode.value
    }
    
}
var myLinkedList = LinkedList<Int>()
myLinkedList.push(50)
myLinkedList.append(10)
myLinkedList.append(15)
myLinkedList.append(20)
myLinkedList.push(40)
myLinkedList.insertAt(after: 10, value: 100)
myLinkedList.pop()
myLinkedList.deleteLast()
myLinkedList

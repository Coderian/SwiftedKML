//
//  Stack.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/04.
//

import Foundation

/// see [The Swift Programming Language(Swift 2.1)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)
public protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
/// see [The Swift Programming Language(Swift 2.1)](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179)
public struct Stack<Element>: Container,CustomStringConvertible {
    public var description: String {
        get {
            return items.description
        }
    }
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    public mutating func append(item: Element) {
        self.push(item)
    }
    public var count: Int {
        return items.count
    }
    public subscript(i: Int) -> Element {
        return items[i]
    }
}

//
//  AncestorSequence.swift
//  CoreUtil
//
//  Created by yuki on 2021/11/25.
//  Copyright © 2021 yuki. All rights reserved.
//

public struct AncestorSequence<Element>: Sequence {
    public struct Iterator: IteratorProtocol {
        @usableFromInline var current: Element?
        @usableFromInline let parent: (Element) -> Element?
        
        @inlinable init(current: Element?, parent: @escaping (Element) -> Element?) {
            self.current = current
            self.parent = parent
        }
        
        @inlinable public mutating func next() -> Element? {
            guard let current = self.current else { return nil }
            self.current = self.parent(current)
            return current
        }
    }
    
    @inlinable public func makeIterator() -> Iterator {
        Iterator(current: self.base, parent: self.parent)
    }
    
    public let base: Element?
    public let parent: (Element) -> Element?
    
    @inlinable public init(base: Element?, parent: @escaping (Element) -> Element?) {
        self.base = base
        self.parent = parent
    }
}

extension AncestorSequence: CustomStringConvertible {
    @inlinable public var description: String {
        self.map{ $0 }.description
    }
}

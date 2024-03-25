//
//  Zip3Sequence.swift
//  CoreUtil
//
//  Created by yuki on 2022/01/22.
//  Copyright © 2022 yuki. All rights reserved.
//

@inlinable public func zip<A: Sequence, B: Sequence, C: Sequence>(_ a: A, _ b: B, _ c: C) -> Zip3Sequence<A, B, C> {
    Zip3Sequence(a, b, c)
}

public struct Zip3Sequence<A: Sequence, B: Sequence, C: Sequence>: Sequence {
    public typealias Element = (A.Element, B.Element, C.Element)
    
    public let a: A
    public let b: B
    public let c: C
    
    public struct Iterator: IteratorProtocol {
        @usableFromInline var a: A.Iterator
        @usableFromInline var b: B.Iterator
        @usableFromInline var c: C.Iterator
        
        @usableFromInline init(a: A.Iterator, b: B.Iterator, c: C.Iterator) {
            self.a = a
            self.b = b
            self.c = c
        }
        
        @inlinable mutating public func next() -> Element? {
            if let a = a.next(), let b = b.next(), let c = c.next() { return (a, b, c) }
            return nil
        }
    }
    
    @inlinable public func makeIterator() -> Iterator {
        Iterator(a: a.makeIterator(), b: b.makeIterator(), c: c.makeIterator())
    }
    
    @inlinable init(_ a: A, _ b: B, _ c: C) {
        self.a = a
        self.b = b
        self.c = c
    }
}

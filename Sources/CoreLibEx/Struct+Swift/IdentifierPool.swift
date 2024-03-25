//
//  IdentifierPool.swift
//  CoreUtil
//
//  Created by yuki on 2023/11/09.
//  Copyright © 2023 yuki. All rights reserved.
//

final public class IdentifierPool<T: FixedWidthInteger> {
    
    @usableFromInline var usingIDs = Set<T>()
    
    @usableFromInline var freeIDs = Set<T>()
    
    @usableFromInline var nextID: T
    
    @usableFromInline let maxID: T
    
    @inlinable public init(initialValue: T = 0, maxID: T = .max) {
        self.nextID = initialValue
        self.maxID = maxID
    }
    
    @inlinable public func create() -> T? {
        let id: T
        if let freeID = self.freeIDs.popFirst() {
            id = freeID
        } else {
            id = self.nextID
            if id == self.maxID {
                return nil
            }
            self.nextID += 1
        }
        self.usingIDs.insert(id)
        return id
    }
    
    @inlinable public func dispose(_ value: T) {
        self.usingIDs.remove(value)
        self.freeIDs.insert(value)
    }
}

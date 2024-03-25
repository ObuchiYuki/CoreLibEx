//
//  ObjectSet.swift
//  CoreUtil
//
//  Created by yuki on 2023/10/18.
//  Copyright © 2023 yuki. All rights reserved.
//

public typealias ObjectSet<T: AnyObject> = [_ObjectIdentifier<T>: T]

extension Dictionary where Key == _ObjectIdentifier<Value> {
    @inlinable public mutating func insert(_ value: Value) {
        self[_ObjectIdentifier(value)] = value
    }
    
    @inlinable public mutating func remove(_ value: Value) {
        self[_ObjectIdentifier(value)] = nil
    }
    
    @inlinable public func contains(_ value: Value) -> Bool {
        self[_ObjectIdentifier(value)] != nil
    }
}


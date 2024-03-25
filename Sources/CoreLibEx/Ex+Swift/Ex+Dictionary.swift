//
//  Ex+Dictionary.swift
//  CoreUtil
//
//  Created by yuki on 2021/05/22.
//  Copyright © 2021 yuki. All rights reserved.
//

extension Dictionary {
    @inlinable public init<S: Sequence>(uniquing sequence: S, by keyForValue: (S.Element) -> (Key)) where Value == S.Element {
        self = sequence.reduce(into: .init(minimumCapacity: sequence.underestimatedCount)) {
            $0[keyForValue($1)] = $1
        }
    }
    
    @inlinable mutating public func setIfNeeded(_ key: Key, make: @autoclosure () -> Value) -> Value {
        if self[key] == nil { self[key] = make() }
        return self[key].unsafelyUnwrapped
    }
    
    @inlinable public mutating func arrayAppend<T>(key: Key, _ value: T) where Value == [T] {
        if self[key] == nil {
            self[key] = []
        }
        self[key]!.append(value)
    }
    
    @inlinable public mutating func dictionarySet<T, K>(key: Key, _ subkey: K, _ value: T) where Value == [K : T] {
        if self[key] == nil {
            self[key] = [:]
        }
        self[key]![subkey] = value
    }
}

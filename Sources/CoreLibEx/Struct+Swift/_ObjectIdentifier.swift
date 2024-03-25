//
//  _ObjectIdentifier.swift
//  CoreUtil
//
//  Created by yuki on 2023/10/18.
//  Copyright © 2023 yuki. All rights reserved.
//

/// Replacement of ``Swift.ObjectIdentifier``
/// A unique identifier for a class instance or metatype.
@frozen
public struct _ObjectIdentifier<T: AnyObject>: Hashable {
    /// The raw value of the object identifier.
    public let rawValue: Int
    
    #if DEBUG
    public weak var __object: T?
    
    @inlinable public var __isAlive: Bool {
        return __object != nil
    }
    #endif
    
    /// Creates an instance that uniquely identifies the given class instance.
    @inlinable public init(_ value: T) {
        self.rawValue = unsafeBitCast(value, to: Int.self)
            
        #if DEBUG
        self.__object = value
        #endif
    }
    
    @inlinable public func hash(into hasher: inout Hasher) {
        #if DEBUG
        assert(self.__isAlive, "attempt to hash _ObjectIdentifier after instance \(T.self) was deallocated")
        #endif
        hasher.combine(rawValue)
    }

    @inlinable public func _rawHashValue(seed: Int) -> Int {
        #if DEBUG
        assert(self.__isAlive, "attempt to hash _ObjectIdentifier after instance \(T.self) was deallocated")
        #endif
        return rawValue._rawHashValue(seed: seed)
    }
}

extension _ObjectIdentifier: Equatable {
    @inlinable public static func == (x: _ObjectIdentifier<T>, y: _ObjectIdentifier<T>) -> Bool {
        #if DEBUG
        assert(x.__isAlive, "attempt to compare _ObjectIdentifier after instance \(T.self) was deallocated")
        assert(y.__isAlive, "attempt to compare _ObjectIdentifier after instance \(T.self) was deallocated")
        #endif
        return x.rawValue == y.rawValue
    }
}

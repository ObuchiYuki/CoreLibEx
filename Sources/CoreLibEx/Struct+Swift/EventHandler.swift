//
//  File.swift
//  
//
//  Created by yuki on 2024/01/02.
//

final public class EventHandler<T> {
    @usableFromInline var handlers = [(T) -> ()]()
    
    @inlinable public init() {}
    
    @inlinable public func on(_ handler: @escaping (T) -> ()) {
        self.handlers.append(handler)
    }
    
    @inlinable public func emit(_ value: T) {
        self.handlers.forEach{ $0(value) }
    }
}


//
//  File.swift
//  
//
//  Created by yuki on 2024/01/02.
//

final public class EventHandler<T> {
    public typealias DisposeID = UInt64
    
    @usableFromInline var handlers = [DisposeID: (T) -> ()]()
    
    @inlinable public init() {}
    
    @inlinable public func on(_ handler: @escaping (T) -> ()) -> DisposeID {
        var id: DisposeID

        repeat {
            id = DisposeID.random(in: .min ... .max)
        } while self.handlers[id] != nil
        
        self.handlers[id] = handler
        return id
    }
    
    @inlinable public func emit(_ value: T) {
        for handler in self.handlers.values {
            handler(value)
        }
    }
    
    @inlinable public func off(_ id: DisposeID) {
        self.handlers[id] = nil
    }
}


//
//  Mirror+Recursive.swift
//  CoreUtil
//
//  Created by yuki on 2021/08/30.
//  Copyright © 2021 yuki. All rights reserved.
//

public struct RecursiveReflectCollection<Subject: AnyObject>: Sequence {
    public struct Iterator: IteratorProtocol {
        public typealias Element = (label: String?, value: Any)
        
        @usableFromInline let subject: Any
        @usableFromInline var index = 0
        @usableFromInline var currentType: AnyClass
        @usableFromInline var currentTypeChildCount: Int
        
        @inlinable init(subject: Subject) {
            let subjectType = type(of: subject)
            self.subject = subject
            self.currentType = subjectType
            self.currentTypeChildCount = Iterator.getChildCount(subject, type: subjectType)
        }
        
        @inlinable public mutating func next() -> Element? {
            while self.index >= self.currentTypeChildCount {
                guard let superclass = _getSuperclass(currentType) else { return nil }
                self.currentType = superclass
                self.currentTypeChildCount = Iterator.getChildCount(subject, type: superclass)
                self.index = 0
            }
            
            let child = Iterator.getChild(of: subject, type: currentType, index: index)
            self.index += 1
            return child
        }
        
        @usableFromInline typealias NameFreeFunc = @convention(c) (UnsafePointer<CChar>?) -> Void

        @inlinable static func getChild<T>(of value: T, type: Any.Type, index: Int) -> Element {
            var nameC: UnsafePointer<CChar>? = nil
            var freeFunc: NameFreeFunc? = nil
            
            let value = self.getChild(of: value, type: type, index: index, outName: &nameC, outFreeFunc: &freeFunc)
            let name = nameC.flatMap({ String(validatingUTF8: $0) })
            
            freeFunc?(nameC)
            
            return (name, value)
        }
        
        @_silgen_name("swift_reflectionMirror_subscript")
        @inlinable static func getChild<T>(of: T, type: Any.Type, index: Int, outName: UnsafeMutablePointer<UnsafePointer<CChar>?>, outFreeFunc: UnsafeMutablePointer<NameFreeFunc?>) -> Any

        @_silgen_name("swift_reflectionMirror_count")
        @inlinable static func getChildCount<T>(_: T, type: Any.Type) -> Int
    }
    
    public let subject: Subject
    
    public init(subject: Subject) { self.subject = subject }
    
    public func makeIterator() -> Iterator { Iterator(subject: self.subject) }
}

extension RecursiveReflectCollection: CustomStringConvertible {
    public var description: String {
        "RecursiveReflectCollection<\(Subject.self)>(\(Array(self))"
    }
}

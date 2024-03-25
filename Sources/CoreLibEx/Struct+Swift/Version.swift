//
//  Version.swift
//  CoreUtil
//
//  Created by yuki on 2021/11/30.
//  Copyright © 2021 yuki. All rights reserved.
//

public struct Version: Hashable {
    public let components: [Int]
    
    @inlinable public init(components: [Int]) {
        self.components = components
    }
    
    @inlinable public init(_ components: Int...) {
        self.components = components
    }
    
    @inlinable public init?<S: StringProtocol>(string: S) {
        let componentsOrNil = string.split(separator: ".").map({ Int($0) })
        
        guard let components = componentsOrNil as? [Int] else { // for Swift5.6 type checker bug
            return nil
        }
        
        self.components = components
    }
}

extension Version: Comparable {
    static public func < (lhs: Version, rhs: Version) -> Bool {
        lhs.description.compare(rhs.description, options: .numeric) == .orderedAscending
    }
}

extension Version: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

extension Version: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard let version = Version(string: string) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "'\(string)' is not valid version string.")
        }
        self = version
    }
}

extension Version: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Int...) {
        self.components = elements
    }
}

extension Version: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let version = Version(string: value) else {
            fatalError("'\(value)' is not valid version string.")
        }
        self = version
    }
}

extension Version: CustomStringConvertible {
    public var description: String {
        components.map{ String($0) }.joined(separator: ".")
    }
}

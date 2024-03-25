//
//  ExtendOptionSet.swift
//  CoreUtil
//
//  Created by yuki on 2020/08/18.
//  Copyright © 2020 yuki. All rights reserved.
//

public protocol ExtendOptionSet: OptionSet, CustomStringConvertible {
    static var options: [(Self, String)] { get }
}

extension ExtendOptionSet {
    @inlinable public static var allOptions: [Self] { Self.options.map { $0.0 } }
}

extension ExtendOptionSet where Self.Element == Self {

    @inlinable public var count: Int {
        var count = 0
        for (option, _) in Self.options { if self.contains(option) { count += 1 } }
        return count
    }

    @inlinable public var flatten: [Self] {
        Self.options.map{ $0.0 }.filter{ self.contains($0) }
    }

    @inlinable public var description: String {
        let options = Self.options
            .filter { option, _ in self.contains(option) }
            .map{ _, name in name }
        
        if options.isEmpty {
            return "\(Self.self)([])"
        } else if options.count == 1 {
            return "\(Self.self).\(options[0])"
        } else {
            return "\(Self.self)([\(options.map{ ".\($0)" }.joined(separator: ", "))])"
        }
    }
}

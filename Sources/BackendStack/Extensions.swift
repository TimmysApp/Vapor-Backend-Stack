//
//  Extensions.swift
//  
//
//  Created by Joe Maghzal on 03/06/2023.
//

import Foundation

extension Sequence {
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }
    func asyncCompactMap<T>(_ transform: (Element) async throws -> T?) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            guard let value = try await transform(element) else {continue}
            values.append(value)
        }
        return values
    }
}

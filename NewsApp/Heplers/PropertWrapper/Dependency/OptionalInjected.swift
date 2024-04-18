//
//  OptionalInjected.swift
//  SwiftBoilerPlate
//
//  Created by user238596 on 10/04/24
//

import Foundation

@propertyWrapper
public class OptionalInjected<Service> {
    public var wrappedValue: Service?

    public init(resolver: Resolver = .default, tag: String? = nil) {
        wrappedValue = resolver.resolve(type: Service.self, tag: tag)
    }
}

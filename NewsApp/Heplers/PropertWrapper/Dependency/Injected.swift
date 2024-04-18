//
//  Injected.swift
//  SwiftBoilerPlate
//
//  Created by user238596 on 10/04/24
//

import Foundation

@propertyWrapper
public class Injected<Service> {
    public var wrappedValue: Service

    public init(resolver: Resolver = .default, tag: String? = nil) {
        guard let value = resolver.resolve(type: Service.self, tag: tag) else {
            fatalError("Unable to resolve type \(String(describing: Service.self))")
        }
        wrappedValue = value
    }
}

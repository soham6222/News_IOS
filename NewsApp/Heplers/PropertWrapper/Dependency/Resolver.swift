//
//  Resolver.swift
//  SwiftBoilerPlate
//
//  Created by user238596 on 10/04/24
//

import Foundation

public class Resolver {
    public struct Key: Hashable {
        var identifier: ObjectIdentifier
        var tag: String?
    }

    public static let `default` = Resolver()
    private var registeries = [Key: Storable]()

    public func register<T>(type: T.Type, tag: String? = nil, factory: @escaping () -> T) {
        let key = Key(
            identifier: ObjectIdentifier(type),
            tag: tag
        )
        let container = Container(factory: factory)
        registeries[key] = container
    }

    public func resolve<T>(type: T.Type, tag: String? = nil) -> T? {
        let key = Key(
            identifier: ObjectIdentifier(type),
            tag: tag
        )

        guard let container = registeries[key] as? Container<T> else {
            return nil
        }

        return container.factory()
    }

    public func unregister<T>(type: T.Type, tag: String? = nil) {
        let key = Key(
            identifier: ObjectIdentifier(type),
            tag: tag
        )

        registeries.removeValue(forKey: key)
    }
}

//
//  Extention+DispatchQueue.swift
//  SwiftBoilerPlate
//
//  Created by user238596 on 10/04/24
//

import Foundation

public extension DispatchQueue {
    func after(time interval: TimeInterval, work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + interval) {
            work()
        }
    }
}

//
//  AppDelegate.swift
//  BoilerPlate
//
//  Created by user238596 on 10/04/24.
//

// MARK: - Project Configuration
// 1. When open project first time `Build` it once to remove `R` not found error.
// 2. Add `SwiftFormat` globaly using `brew install swiftformat` command. (Refrance:- https://github.com/nicklockwood/SwiftFormat.git)
// 3. Add `SwiftLint` globaly using `brew install swiftlint` command. (Refrance:- https://github.com/realm/SwiftLint.git)
// 4. Build project onece to remove all `Error` and format code.

import IQKeyboardManagerSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        return true
    }
}

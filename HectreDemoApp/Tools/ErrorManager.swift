////
////  ErrorManager.swift
////  HectreDemoApp
////
////  Created by Viajeros Lado B on 01/08/2020.
////  Copyright © 2020 ArielBurgos. All rights reserved.
////
//

import Foundation
//import FirebaseCrashlytics
//import FirebaseAnalytics

// FIXME : Add Firebase
struct ErrorManager {

    static func trackExeption(name: String, reason: String? = nil, extraData: [String: String]? = nil, path: String = #file, line: Int = #line, function: String = #function) {
        let file = URL(fileURLWithPath: path).lastPathComponent
        let logHeader = "[\(file)] [on: \(function)] [line:\(line)]"

        let error = NSError(domain: "\(logHeader) \(name)", code: 100, userInfo: extraData)
        print(error)
//        Crashlytics.crashlytics().record(error: error)
    }

    static func trackExeption(error: Error, path: String = #file, line: Int = #line, function: String = #function) {
        
        print(error)
//        Crashlytics.crashlytics().record(error: error)
    }

        static func trackOpenView(className: String) {
//            Analytics.setScreenName(className, screenClass: className)
//            Crashlytics.crashlytics().log("Did load view: \(className)")
            print("Did load view: \(className)")

        }

    static func dropBreadCrumb(breadCrumb: String, extraData: [String: String]? = nil, path: String = #file, line: Int = #line, function: String = #function) {
        let file = URL(fileURLWithPath: path).lastPathComponent
        let logHeader = "[\(file)] [on: \(function)] [line:\(line)]"

        print("\(logHeader) \(breadCrumb)")

//        Crashlytics.crashlytics().log("\(logHeader) \(breadCrumb)")
    }

    #if DEBUG
    static func makeCrash() {
        fatalError("Test Crash")
    }
    #endif
}

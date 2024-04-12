//
//  AppEnvironment.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/12.
//

import Foundation

enum AppEnvironment {
    static var serverURL: String {
        "api.github.com"
    }
    
    static var scheme: String {
        "https"
    }
    
    static var env: String {
        #if DEBUG
        "uat"
        #else
        "prod"
        #endif
    }
}

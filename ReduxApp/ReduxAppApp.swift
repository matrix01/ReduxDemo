//
//  ReduxAppApp.swift
//  ReduxApp
//
//  Created by Milan on 2024/03/21.
//

import SwiftUI

@main
struct ReduxAppApp: App {
    var body: some Scene {
        let store = Store(
            reducer: appReducer,
            state: AppState(),
            middlewares: [
                userListMiddleware()
            ]
        )
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}

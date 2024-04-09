//
//  ContentView.swift
//  ReduxApp
//
//  Created by Milan on 2024/03/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store<AppState>
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            CounterView()
                .tabItem {
                    Label(
                        title: { /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/ },
                        icon: { Image(systemName: "42.circle") }
                    )
                }
                .tag(0)
        }
        .environmentObject(store)
    }
}

#Preview {
    ContentView()
        .environmentObject(Store(reducer: appReducer, state: AppState()))
}

//
//  CounterView.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/10.
//

import SwiftUI

struct CounterView: View {
    @EnvironmentObject var store: Store<AppState>
    
    private struct Props {
        let count: Int
        
        let increment: CounterAction
        let decrement: CounterAction
    }
    
    private func mapStateToProps(state: CounterState) -> Props {
        return Props(
            count: store.state.counterState.counter,
            increment: .increment,
            decrement: .decrement
        )
    }
    
    var body: some View {
        let props = mapStateToProps(state: store.state.counterState)
        let _ = Self._printChanges()
        VStack(spacing: 16) {
            Text("Welcom to counting...")
            Text("Your count: \(props.count)")
            HStack {
                Button(action: {
                    store.dispatch(action: props.increment)
                }, label: {
                    Text("Increment")
                })
                
                Button(action: {
                    store.dispatch(action: props.decrement)
                }, label: {
                    Text("Decrement")
                })
            }
        }
    }
}

#Preview {
    CounterView()
        .environmentObject(Store(reducer: appReducer, state: AppState()))
}

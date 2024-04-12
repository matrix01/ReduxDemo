//
//  CounterReducer.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/10.
//

import Foundation

func counterReducer(_ state: CounterState, _ action: CounterAction) -> CounterState {
    var state = state
    switch action {
    case .increment:
        state.counter += 1
    case .decrement:
        state.counter -= 1
    }
    return state
}

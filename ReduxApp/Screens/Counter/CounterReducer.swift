//
//  CounterReducer.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/10.
//

import Foundation

func counterReducer(_ state: CounterState, _ action: Action) -> CounterState {
    var state = state
    guard let action = action as? CounterAction else {
        assertionFailure("Invalid action passed")
        return state
    }
    switch action {
    case .increment:
        state.counter += 1
    case .decrement:
        state.counter -= 1
    }
    return state
}

//
//  AppReducer.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/09.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state
    
    state.counterState = counterReducer(state.counterState, action)
    
    return state
}

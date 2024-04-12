//
//  AppReducer.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/09.
//

import Foundation

func appReducer(_ state: AppState, _ action: Any) -> AppState {
    var state = state
    
    if let counterAction = action as? CounterAction {
        state.counterState = counterReducer(state.counterState, counterAction)
    }
    
    if let userListAction = action as? UserListAction {
        state.userListState = userListReducer(state.userListState, userListAction)
    }
    
    return state
}

//
//  UserListReducer.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/13.
//

import Foundation

func userListReducer(_ state: UserListState, _ action: UserListAction) -> UserListState {
    var state = state
    
    switch action {
    case .fetchUsers:
        state.isLoading = true
        state.error = nil
        return state

    case .fetchUsersSuccess(let users):
        state.isLoading = false
        state.users = users
        return state

    case .fetchUsersFailure(let error):
        state.isLoading = false
        state.error = error
        return state
    }
}

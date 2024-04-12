//
//  UserListState.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/13.
//

import Foundation

struct UserListState: ReduxState, Equatable {
    var users: [SimpleUser] = []
    var isLoading: Bool = false
    var error: DecodedErrors? = nil
    
    static func == (lhs: UserListState, rhs: UserListState) -> Bool {
        return lhs.users == rhs.users &&
        lhs.isLoading == rhs.isLoading &&
        lhs.error?.localizedDescription == rhs.error?.localizedDescription
    }
}

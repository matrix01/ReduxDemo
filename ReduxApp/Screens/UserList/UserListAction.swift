//
//  UserListAction.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/13.
//

import Foundation

enum UserListAction: Action {
    case fetchUsers
    case fetchUsersSuccess([SimpleUser])
    case fetchUsersFailure(DecodedErrors)
    case selectUser(userId: Int)
}

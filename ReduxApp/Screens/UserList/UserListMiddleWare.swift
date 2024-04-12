//
//  userListMiddleWare.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/13.
//

import Foundation

func userListMiddleware() -> Middleware<AppState> {
    return { state, action, networkClient, dispatch in
        if let userListAction = action as? UserListAction, case .fetchUsers = userListAction {
            requestUserList(networkClient: networkClient, dispatch: dispatch)
        }
    }
}

private func requestUserList(networkClient: NetworkService, dispatch: @escaping Dispatcher) {
    Task { @MainActor in
        do {
            let users: [SimpleUser] = try await networkClient.execute(endpoint: GitEndPoints.users)
            dispatch(UserListAction.fetchUsersSuccess(users))
        } catch {
            guard let error = error as? DecodedErrors else {
                dispatch(UserListAction.fetchUsersFailure(.none))
                return
            }
            dispatch(UserListAction.fetchUsersFailure(error))
        }
    }
}

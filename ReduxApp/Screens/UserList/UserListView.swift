//
//  UserListView.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/13.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var store: Store<AppState>
    
    private struct Props {
        let users: [SimpleUser]
        let error: DecodedErrors?
        let fetch: UserListAction
    }
    
    private func mapStateToProps(state: UserListState) -> Props {
        return Props(
            users: store.state.userListState.users, 
            error: store.state.userListState.error,
            fetch: .fetchUsers
        )
    }
    
    var body: some View {
        let props = mapStateToProps(state: store.state.userListState)
        List(props.users) { user in
            UserRow(user: user)
        }
        .task {
            store.dispatch(action: props.fetch)
        }
    }
}

struct UserRow: View {
    var user: SimpleUser
    
    var body: some View {
        HStack {
            AsyncImage(url: user.avatarUrl)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.name ?? user.login)
                    .font(.headline)
                Text(user.email ?? "No email available")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}


#Preview {
    UserListView()
        .environmentObject(Store(reducer: appReducer, state: AppState()))
}

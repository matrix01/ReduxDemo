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
        let fetch: () -> Void
        let setSelected: (SimpleUser) -> Void
        let isActive: () -> Binding<[SimpleUser]>
    }

    private func mapStateToProps(state: UserListState) -> Props {
        return Props(
            users: state.users,
            error: state.error,
            fetch: { store.dispatch(action: UserListAction.fetchUsers) },
            setSelected: { user in
                store.dispatch(action: UserListAction.selectUser(userId: user.id))
            },
            isActive: {
                Binding<[SimpleUser]>(
                    get: { [state.selectedUser].compactMap{$0} },
                    set: { _ in }
                )
            }
        )
    }
    
    var body: some View {
        let props = mapStateToProps(state: store.state.userListState)
        NavigationStack(path: props.isActive()) {
            List(props.users) { user in
                UserRow(user: user)
                    .onTapGesture {
                        props.setSelected(user)
                    }
            }
            .navigationDestination(for: SimpleUser.self) { _ in
                UserDetailView()
                    .environmentObject(store)
            }
            .task {
                props.fetch()
            }
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

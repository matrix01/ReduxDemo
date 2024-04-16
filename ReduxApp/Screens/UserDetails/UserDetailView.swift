//
//  UserDetailView.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/14.
//

import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    
    private struct Props {
        let userName: String
    }
    
    private func mapStateToProps(state: UserListState) -> Props {
        return Props(
            userName: state.selectedUser?.login ?? "No name"
        )
    }
    
    var body: some View {
        let props = mapStateToProps(state: store.state.userListState)
        Text(props.userName)
            .font(.title)
    }
}

#Preview {
    UserDetailView()
        .environmentObject(Store(reducer: appReducer, state: AppState()))
}

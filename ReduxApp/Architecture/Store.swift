//
//  Store.swift
//  ReduxApp
//
//  Created by Milan on 2024/03/22.
//

import Foundation

// MARK: - Typealias
typealias Dispatcher = (Action) -> Void
typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, NetworkService, @escaping Dispatcher) -> Void

// MARK: - Protocol
protocol ReduxState {}

protocol Action {}

// MARK: - Store
final class Store<StoreState: ReduxState>: ObservableObject {

    // MARK: - Property
    @Published private(set) var state: StoreState
    private var reducer: Reducer<StoreState>
    private var middlewares: [Middleware<StoreState>]
    private var networkClient: NetworkService

    // MARK: - Initialzer
    init(
        reducer: @escaping Reducer<StoreState>,
        state: StoreState,
        middlewares: [Middleware<StoreState>] = [],
        networkClient: NetworkService = .init()
    ) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
        self.networkClient = networkClient
    }

    // MARK: - Function
    func dispatch(action: Action) {
        Task { @MainActor in
            self.state = reducer(self.state, action)
        }
        
        middlewares.forEach { middleware in
            middleware(state, action, networkClient, dispatch)
        }
    }
}

//
//  CounterState.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/10.
//

import Foundation

struct CounterState: ReduxState, Equatable {
    var counter: Int = 0
}

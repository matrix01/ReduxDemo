//
//  ToranokoError.swift
//  Toranoko
//
//  Created by Mia Milan on 2022/04/12.
//  Copyright © 2022 TORANOTEC K.K. All rights reserved.
//

import Foundation

/// Base declaration for Toranoko App errors
/// Add proper case for additional errors
enum DecodedErrors: Error, LocalizedError {
	case parsing(description: String)
	case network(description: String, data: Data?)
	case legacy(description: String)
	case none

	var errorDescription: String? {
        switch self {
        case .parsing(let description):
            return description

        case .network(let description, _):
            return description

        case .legacy(let description):
            return description

        case .none:
            return localizedDescription
        }
	}

	var errorMessage: String? {
		errorDescription
	}
}

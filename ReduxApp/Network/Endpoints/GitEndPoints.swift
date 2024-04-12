//
//  GitEndPoints.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/12.
//

import Foundation

enum GitEndPoints: EndPointType {
    case users
    
    var path: String {
        switch self {
        case .users:
            return "users"
        }
    }
    
    var method: HTTPMethodType {
        .GET
    }
    
    var params: [URLQueryItem]? {
        return nil
    }
    
    
}

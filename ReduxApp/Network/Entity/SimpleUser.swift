//
//  Entity.swift
//  ReduxApp
//
//  Created by Milan on 2024/04/13.
//

import Foundation

struct SimpleUser: Codable {
    let name: String?
    let email: String?
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: URL
    let gravatarId: String?
    let url: URL
    let htmlUrl: URL
    let followersUrl: URL
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: URL
    let organizationsUrl: URL
    let reposUrl: URL
    let eventsUrl: String
    let receivedEventsUrl: URL
    let type: String
    let siteAdmin: Bool
    let starredAt: String?
}

extension SimpleUser: Identifiable {
    /*
     Empty
     */
}

extension SimpleUser: Hashable {
    /*
     Empty
     */
}

extension SimpleUser: Equatable {
    static func == (lhs: SimpleUser, rhs: SimpleUser) -> Bool {
        return lhs.email == rhs.email &&
        lhs.login == rhs.login &&
        lhs.id == rhs.id &&
        lhs.url == rhs.url
    }
}

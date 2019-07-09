//
//  GHSearchDetailModel.swift
//  GitHubSearch
//
//  Created by apple on 7/9/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
struct GHSearchDetailModel: Codable {
    let login: String?
    let id: String?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: String?
    let name: String?
    let company: String?
    let blog: String?
    let location, email: String?
    let hireable: String?
    let bio: String?
    let publicRepos, publicGists, followers, following: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension GHSearchDetailModel {
    static func getSearchUserDetails(withDictionay : [String : Any]) -> GHSearchDetailModel? {
        let model = GHSearchDetailModel.init(login: "\(withDictionay["login"] ?? "")", id: "\(withDictionay["id"] ?? "")", nodeID: "\(withDictionay["node_id"] ?? "")", avatarURL: "\(withDictionay["avatar_url"] ?? "")", gravatarID: "\(withDictionay["gravatar_id"] ?? "")", url: "\(withDictionay["url"] ?? "")", htmlURL: "\(withDictionay["html_url"] ?? "")", followersURL: "\(withDictionay["followers_url"] ?? "")", followingURL: "\(withDictionay["following_url"] ?? "")", gistsURL: "\(withDictionay["gists_url"] ?? "")", starredURL: "\(withDictionay["starred_url"] ?? "")", subscriptionsURL: "\(withDictionay["subscriptions_url"] ?? "")", organizationsURL: "\(withDictionay["organizations_url"] ?? "")", reposURL: "\(withDictionay["repos_url"] ?? "")", eventsURL: "\(withDictionay["events_url"] ?? "")", receivedEventsURL: "\(withDictionay["received_events_url"] ?? "")", type: "\(withDictionay["type"] ?? "")", siteAdmin: "\(withDictionay["siteAdmin"] ?? "")", name: "\(withDictionay["name"] ?? "")", company: "\(withDictionay["company"] ?? "")", blog: "\(withDictionay["blog"] ?? "")", location: "\(withDictionay["location"] ?? "")", email: "\(withDictionay["email"] ?? "")", hireable: "\(withDictionay["hireable"] ?? "")", bio: "\(withDictionay["bio"] ?? "")", publicRepos: "\(withDictionay["public_repos"] ?? "")", publicGists: "\(withDictionay["public_gists"] ?? "")", followers: "\(withDictionay["followers"] ?? "")", following: "\(withDictionay["following"] ?? "")", createdAt: "\(withDictionay["createdAt"] ?? "")", updatedAt: "\(withDictionay["updatedAt"] ?? "")")
        return model
    }
}

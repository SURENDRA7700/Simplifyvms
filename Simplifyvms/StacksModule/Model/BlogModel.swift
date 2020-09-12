//
//  BlogModel.swift
//  Simplifyvms
//
//  Created by surendra kumar k on 12/09/20.
//  Copyright © 2020 Semanoor. All rights reserved.
//

import Foundation

struct BlogStocksModel: Codable {
    let items: [Item]?
    let hasMore: Bool?
    let quotaMax, quotaRemaining: Int?

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

// MARK: - Item
struct Item: Codable {
    let tags: [String]?
    let owner: Owner?
    let isAnswered: Bool?
    let viewCount: Int?
    let acceptedAnswerID: Int?
    let answerCount, score, lastActivityDate, creationDate: Int?
    let questionID: Int?
    let contentLicense: ContentLicense?
    let link: String?
    let title: String?
    let lastEditDate, closedDate: Int?
    let closedReason: String?
    var isSelectedFav: Bool? = false


    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case acceptedAnswerID = "accepted_answer_id"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case questionID = "question_id"
        case contentLicense = "content_license"
        case link, title
        case lastEditDate = "last_edit_date"
        case closedDate = "closed_date"
        case closedReason = "closed_reason"
    }
}

enum ContentLicense: String, Codable {
    case ccBySa30 = "CC BY-SA 3.0"
    case ccBySa40 = "CC BY-SA 4.0"
}

// MARK: - Owner
struct Owner: Codable {
    let reputation, userID: Int
    let userType: UserType
    let acceptRate: Int?
    let profileImage: String
    let displayName: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case acceptRate = "accept_rate"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
}

enum UserType: String, Codable {
    case registered = "registered"
}

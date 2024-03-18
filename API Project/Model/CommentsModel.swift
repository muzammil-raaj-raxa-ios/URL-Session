//
//  CommentsModel.swift
//  API Project
//
//  Created by Mag isb-10 on 14/03/2024.
//

import Foundation

struct CommentsModel: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

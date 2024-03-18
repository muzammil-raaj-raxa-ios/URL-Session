//
//  UsersModel.swift
//  API Project
//
//  Created by Mag isb-10 on 14/03/2024.
//

import Foundation

struct UsersModel: Decodable {
    let id: Int
    let name, username, email: String
    let phone, website: String
}

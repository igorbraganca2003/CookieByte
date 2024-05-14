//
//  UserModel .swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 14/05/24.
//

struct UserModel {
    let name: String
    let password: String
    let profilePic: String
    let points: Int
    let localization: Bool
    let order: [Order]
}

//
//  ShopResponseModel.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//

import Foundation

// MARK: - ShopResponseModelElement
struct ShopResponseModel: Codable {
    let shopName: String?
    var items: [Item]?

    enum CodingKeys: String, CodingKey {
        case shopName = "shop_name"
        case items
    }
}

// MARK: - Item
class Item: Codable {
    let name, description: String?
    let price: Int?
    let image: String?
    var itemcount: Int?
}




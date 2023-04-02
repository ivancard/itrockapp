//
//  IZINotification.swift
//  Izipark
//
//  Created by Ignacio Arias on 20/03/2023.
//

import Foundation

struct IZINotification: Codable {
    var id: Int?
    var userId: Int?
    var parkingOrderId: Int?
    var title: String?
    var description: String?
    var read: String?
    var type: Bool?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId         = "user_id"
        case parkingOrderId = "parking_order_id"
        case title
        case description
        case read
        case type
        case createdAt      = "created_at"
        case updatedAt      = "updated_at"
    }
}

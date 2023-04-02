//
//  Coupon.swift
//  Izipark
//
//  Created by Jonathan Montes de Oca on 17/03/2023.
//

import Foundation

struct Coupon: Codable {
    var id: Int?
    var coupon: CouponDetails?
    var isUsed: Bool?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case coupon
        case isUsed    = "is_used"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

struct CouponDetails: Codable {
    var title: String?
    var description: String?
    var code: String?
    var discountPercentage: Int?
    var expireDate: String?
    var type: String?
    var freeMinutes: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case code
        case discountPercentage = "discount_percentage"
        case expireDate         = "expire_date"
        case type
        case freeMinutes        = "free_minutes"
    }
}

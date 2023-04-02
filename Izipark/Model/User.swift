//
//  User.swift
//  Izipark
//
//  Created by Jonathan Montes de Oca on 17/03/2023.
//

import Foundation

struct User: Codable, UserDefaultsCodable {
    var id: String?
    var accessToken: String?
    var fullName: String?
    var email: String?
    var verifiedEmail: Bool?
    var phoneNumber: String?
    var profilePicture: String?
    var bannerPicture: String?
    var referralCode: String?
    var paymentAccount: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case accessToken    = "access_token"
        case fullName       = "fullname"
        case email
        case verifiedEmail  = "verified_email"
        case phoneNumber    = "phone_number"
        case profilePicture = "profile_picture"
        case bannerPicture  = "banner_picture"
        case referralCode   = "referral_code"
        case paymentAccount = "payment_account"
    }
}

//
//  APIClient+User.swift
//  Izipark
//
//  Created by Jonathan Montes de Oca on 17/03/2023.
//

import Foundation
import UIKit

extension APIClient {
    enum User {}
}

extension APIClient.User {
    struct GetProfile: APIRequest {
        typealias ResponseType = User
        
        var userID: String?
        
        var method: HTTPMethod { return .get }
        var path: String { "user/profile" }
        
        var parameters: [String : Any?]? {
            return [
                "user_id" : userID
            ]
        }
    }
    
    struct EditProfile: APIRequest {
        typealias ResponseType = User

        var fullName:       String?
        var email:          String?
        var phoneNumber:    String?
        var profilePicture: String?
        var bannerPicture:  String?
        var gender:         String?
        
        var method: HTTPMethod { return .post }
        var path: String { "user/profile" }
        
        var parameters: [String : Any?]? {
            return [
                "full_name"       : fullName,
                "email"           : email,
                "phone_number"    : phoneNumber,
                "profile_picture" : profilePicture,
                "banner_picture"  : bannerPicture,
                "gender"          : gender
                
            ]
        }
    }
    
    struct ChangePassword: APIRequest {
        typealias ResponseType = GenericResponse
        
        var oldPassword: String?
        var newPassword: String?
        
        var method: HTTPMethod { return .post }
        var path: String { "user/change_password" }
        
        var parameters: [String : Any?]? {
            return [
                "old_password" : oldPassword,
                "new_password" : newPassword,
                "access_token" : User.current?.accessToken ?? ""
            ]
        }
    }
    
    struct GetCoupons: APIRequest {
        typealias ResponseType = [Coupon]
        
        var available: Bool?
        
        var method: HTTPMethod { return .get }
        var path: String { "user/coupons" }
        
        var parameters: [String : Any?]? {
            return [
                "available" : available
            ]
        }
    }
    
    struct ReferralCode: APIRequest {
        typealias ResponseType = GenericResponse
        
        var referralCode: String?
        
        var method: HTTPMethod { return .post }
        var path: String { "user/use_referral_code" }
        
        var parameters: [String : Any?]? {
            return [
                "referral_code" : referralCode
            ]
        }
    }
    
    struct SaveCbuAlias: APIRequest {
        typealias ResponseType = User
        
        var cbuAlias: String?
        
        var method: HTTPMethod { return .post }
        var path: String { "user/save_cbu_alias" }
        
        var parameters: [String : Any?]? {
            return [
                "cbu_alias" : cbuAlias
            ]
        }
    }
    
    struct DeleteAccount: APIRequest {
        typealias ResponseType = GenericResponse
        
        var method: HTTPMethod { return .delete }
        var path: String { "user/delete_account" }
        
        var parameters: [String : Any?]? {
            return [
                "access_token" : User.current?.accessToken ?? ""
            ]
        }
    }
}

//
//  APIClient+Auth.swift
//  artppl
//
//  Created by ivan cardenas on 28/10/2022.
//

import Foundation
import UIKit

extension APIClient {
    enum Auth {}
}

extension APIClient.Auth {
    struct Register: APIRequest {
        typealias ResponseType = User
        
        var fullName:       String?
        var phoneNumber:    String?
        var email:          String?
        var password:       String?
        
        var method: HTTPMethod { return .post }
        var path: String { "register" }
        
        var parameters: [String : Any?]? {
            return [
                "fullname"     : fullName,
                "phone_number"  : phoneNumber,
                "email"         : email,
                "password"      : password
            ]
        }
    }
    
    struct Login: APIRequest {
        typealias ResponseType = User
        
        var email:      String?
        var password:   String?
        
        var method: HTTPMethod { return .post }
        var path: String { return "login" }
        var parameters: [String : Any?]? {
            return [
                "email"    : email,
                "password" : password,
            ]
        }
    }
    
    struct RegisterGoogle: APIRequest {
        typealias ResponseType = User
        
        var googleId: String?
        var googleToken: String?

        var method: HTTPMethod { return .post }
        var path: String { "register_google" }
        
        var parameters: [String : Any?]? {
            return [
                "google_id"    : googleId,
                "google_token" : googleToken,
            ]
        }
    }
    
    struct RegisterApple: APIRequest {
        typealias ResponseType = User
        
        var appleId: String?
        var fullName: String?
        var email: String?
        
        var method: HTTPMethod { return .post }
        var path: String { "register_apple" }
        
        var parameters: [String : Any?]? {
            return [
                "apple_id"      : appleId,
                "full_name"     : fullName,
                "email"         : email
            ]
        }
    }
    
    struct LogOut: APIRequest {
        typealias ResponseType = GenericResponse
        
        var deviceToken: String?
        
        var method: HTTPMethod {return .post}
        var path: String {"logout"}
        
        var parameters: [String : Any?]? {
            return [
                "device_token" : deviceToken
            ]
        }
    }
    
    struct RegisterDeviceToken: APIRequest {
        typealias ResponseType = GenericResponse
        
        var deviceToken:    String?
        var deviceType:     String?

        var method: HTTPMethod {return .post}
        var path: String {"register_device_token"}
        
        var parameters: [String : Any?]? {
            return [
                "device_token"  : deviceToken,
                "device_type"   : deviceType
            ]
        }
    }
    
    struct ValidateEmail: APIRequest {
        typealias ResponseType = GenericResponse
        
        var email:    String?
        
        var method: HTTPMethod {return .post}
        var path: String {"validate_email"}
        
        var parameters: [String : Any?]? {
            return [
                "email"  : email
            ]
        }
    }
    
    struct SendCodeValidation: APIRequest {
        typealias ResponseType = GenericResponse
        
        var email:  String?
        var code:   String?
        
        var method: HTTPMethod {return .post}
        var path: String {"send_code_validation"}
        
        var parameters: [String : Any?]? {
            return [
                "email" : email,
                "code"  : code
            ]
        }
    }
    
    struct ForgotPassword: APIRequest {
        typealias ResponseType = GenericResponse
        
        var email:  String?

        var method: HTTPMethod {return .post}
        var path: String {"forgot_password"}
        
        var parameters: [String : Any?]? {
            return [
                "email" : email
            ]
        }
    }
}

//
//  Log.swift
//  Ignite
//
//  Created by Nicolas Bolzan on 12/08/2020.
//  Copyright © 2020 InfinixSoft. All rights reserved.
//

import Foundation

extension APIRequest {
    
    func logRequest(params: [String: Any?]) {
        guard log, !params.isEmpty else { return }
        print("-------------------------------------------------------")
        print("Dispatching request to => \(APIClient.BASE_URL + path)")
        print("Method => \(method.rawValue)")
        print("Parameters => \(getPrintableJSON(params))")
        print("-------------------------------------------------------")
    }
    
    func logResponse(data: Data, response: HTTPURLResponse) {
        guard log else { return }
        print("-------------------------------------------------------")
        print("Response received from => \(response.url?.description ?? "")")
        print("Status code => \(response.statusCode)")
        
        if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("Received JSON => \(self.getPrintableJSON(responseJSON))")
        } else {
            print("Received JSON => null")
        }
        print("-------------------------------------------------------")
    }
    
    func JSONStringify(_ value: AnyObject) -> String{
        
        if JSONSerialization.isValidJSONObject(value) {
            do{
                let data = try JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
                
            } catch {
                print("error")
            }
        }
        return ""
    }

    func getPrintableJSON(_ json: AnyObject) -> NSString {
        return JSONStringify(json) as NSString
    }

    func getPrintableJSON(_ json: Any) -> NSString {
        return getPrintableJSON(json as AnyObject)
    }
}

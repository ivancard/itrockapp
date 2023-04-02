//
//  UserDefaultsCodable.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 08/03/2023.
//

import Foundation

fileprivate let appName = (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String) ?? "APP"

protocol UserDefaultsCodable {}

extension UserDefaultsCodable where Self: Codable {
        
    static var current: Self? {
        get {
            let userDefaultsKey = "\(appName)_CURRENT_\(String(describing: self))".uppercased()

            guard
                let userJSON = UserDefaults.standard.object(forKey: userDefaultsKey),
                let userData = try? JSONSerialization.data(withJSONObject: userJSON, options: [])
            else { return nil }
            
            return try? JSONDecoder().decode(Self.self, from: userData)
        }
        set {
            let userDefaultsKey = "\(appName)_CURRENT_\(String(describing: self))".uppercased()

            if newValue == nil {
                UserDefaults.standard.set(nil, forKey: userDefaultsKey)
                UserDefaults.standard.synchronize()
                return
            }
            
            guard
                let data = try? JSONEncoder().encode(newValue),
                let objectJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return }
            
            UserDefaults.standard.set(objectJSON, forKey: userDefaultsKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func save() {
        Self.current = self
    }
    
    func clear() {
        Self.current = nil
    }
}

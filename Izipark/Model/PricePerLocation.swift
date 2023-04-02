//
//  PricePerLocation.swift
//  Izipark
//
//  Created by Ignacio Arias on 20/03/2023.
//

import Foundation
import MapboxSearch

struct PricePerLocation: Codable {
    var price: Int?
    var provinceId: Int?
    var cityId: Int?
    
    enum CodingKeys: String, CodingKey {
        case price
        case provinceId = "province_id"
        case cityId     = "city_id"
    }
}

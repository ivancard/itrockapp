//
//  Spot.swift
//  Izipark
//
//  Created by fabian zarate on 03/03/2023.
//

import Foundation
import MapboxSearch

struct Spot: Codable, UserDefaultsCodable {
    var typeSpotId: Int?
    var provinceId: Int?
    var cityId: Int?
    var latitud: CLLocationDegrees?
    var longitud: CLLocationDegrees?
    var availability: String?
    var timeFrom: String?
    var timeTo: String?
    var status: String?
    var size: String?
    
    enum CodingKeys: String, CodingKey {
        case typeSpotId = "type_spot_id"
        case provinceId = "province_id"
        case cityId     = "city_id"
        case latitud
        case longitud
        case availability
        case timeFrom   = "time_from"
        case timeTo     = "time_to"
        case status
        case size
    }
}

struct SpotAmenity: Codable {
    var id: Int?
    var name: String?
    var iconPicture: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconPicture = "icon_picture"
    }
}
struct SpotStepInformation: Codable {
    var stepNumber: String?
    var descriptionStep: String?
    var titleStep: String?
    var imageStep: String?
}

//
//  APIClient+Spot.swift
//  Izipark
//
//  Created by Ignacio Arias on 20/03/2023.
//

import Foundation
import UIKit

extension APIClient {
    enum Spot {}
}

extension APIClient.Spot {
    struct CreateSpot: APIRequest {
        typealias ResponseType = Spot

        var typeSpotID: Int?
        var provinceID: Int?
        var cityID: Int?
        var latitud : Int?
        var longitud : Int?
        var availability: String?
        var timeFrom: String?
        var timeTo: String?
        var status: String?
        var size: String?

        var method: HTTPMethod { return .post }
        var path: String { "spot/create_spot" }

        var parameters: [String : Any?]? {
            return [
                "type_spot_id": typeSpotID,
                "province_id": provinceID,
                "city_id": cityID,
                "latitude": latitud,
                "longitude": longitud,
                "availability": availability,
                "time_from": timeFrom,
                "time_to": timeTo,
                "status": status,
                "size": size
            ]
        }
    }

    struct RentSpot: APIRequest {
        typealias ResponseType = Spot

        var spotID: Int?
        var carID: Int?
        var price: Int?
        var timeQuantity: Int?
        var timeFrom: String?
        var timeTo: String?

        var method: HTTPMethod { return .post }
        var path: String { "spot/rent_spot" }

        var parameters: [String : Any?]? {
            return [
                "spot_id": spotID,
                "car_id": carID,
                "price": price,
                "time_quantity": timeQuantity,
                "time_from": timeFrom,
                "time_to": timeTo
            ]
        }
    }
    
    struct GetNearSpots: APIRequest {
        typealias ResponseType = [Spot]

        var latitud : Int?
        var longitud : Int?
        var radio: Int?
        var timeFrom: String?
        var timeTo: String?

        var method: HTTPMethod { return .get }
        var path: String { "spot/get_near_spots" }

        var parameters: [String : Any?]? {
            return [
                "latitude": latitud,
                "longitude": longitud,
                "radio": radio,
                "time_from": timeFrom,
                "time_to": timeTo
            ]
        }
    }
    
    struct GetHistory: APIRequest {
        typealias ResponseType = [Spot]

        var page: Int?

        var method: HTTPMethod { return .get }
        var path: String { "spot/get_history" }

        var parameters: [String : Any?]? {
            return [
                "page" : page
            ]
        }
    }

    struct GetTypes: APIRequest {
        typealias ResponseType = [Spot]

        var method: HTTPMethod { return .get }
        var path: String { "spot/get_types" }

        var parameters: [String : Any?]? {
            return nil
        }
    }

    struct GetAmenities: APIRequest {
        typealias ResponseType = [SpotAmenity]

        var typeSPotID: Int?

        var method: HTTPMethod { return .get }
        var path: String { "spot/get_amenities" }

        var parameters: [String : Any?]? {
            return [
                "type_spot_id" : typeSPotID
            ]
        }
    }
    
    struct ChangeStatusRentOrder: APIRequest {
        typealias ResponseType = Spot

        var rentOrderID: Int?
        var status: String?
        var statusPayment: String?
        
        var method: HTTPMethod { return .post }
        var path: String { "spot/change_status_rent_order" }

        var parameters: [String : Any?]? {
            return [
                "rent_order_id" : rentOrderID,
                "status"        : status,
                "status_payment": statusPayment
            ]
        }
    }
}

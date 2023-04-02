//
//  APIClient+Price.swift
//  Izipark
//
//  Created by Ignacio Arias on 20/03/2023.
//

import Foundation
import UIKit

extension APIClient {
    enum Price {}
}

extension APIClient.Price {
    struct GetPriceByLocation: APIRequest {
        typealias ResponseType = PricePerLocation

        var provinceName: Int?
        var cityName: String?
        var zipCode: String?

        var method: HTTPMethod { return .get }
        var path: String { "price/get_price_by_location" }

        var parameters: [String : Any?]? {
            return [
                "province_name": provinceName,
                "city_name": cityName,
                "zip_code": zipCode
            ]
        }
    }
}

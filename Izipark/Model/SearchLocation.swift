//
//  SearchLocation.swift
//  Izipark
//
//  Created by fabian zarate on 15/02/2023.
//

import Foundation
import MapboxSearch

struct SearchLocation: Codable, UserDefaultsCodable {
    var name: String?
    var address: String?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    init(name: String?, address: String?, coordinate: CLLocationCoordinate2D?) {
        self.name = name
        self.address = address
        self.latitude = coordinate?.latitude
        self.longitude = coordinate?.longitude
    }
}

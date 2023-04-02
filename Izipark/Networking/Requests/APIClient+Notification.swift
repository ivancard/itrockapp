//
//  APIClient+Notification.swift
//  Izipark
//
//  Created by Ignacio Arias on 20/03/2023.
//

import Foundation
import UIKit

extension APIClient {
    enum Notificacion {}
}

extension APIClient.Notificacion {
    struct ReadNotification: APIRequest {
        typealias ResponseType = IZINotification

        var notificationID: Int?

        var method: HTTPMethod { return .post }
        var path: String { "notifications/read" }

        var parameters: [String : Any?]? {
            return [
                "notification_id": notificationID
            ]
        }
    }

    struct GetNotification: APIRequest {
        typealias ResponseType = [IZINotification]

        var page : Int?

        var method: HTTPMethod { return .get }
        var path: String { "notifications" }

        var parameters: [String : Any?]? {
            return [
                "page": page,
            ]
        }
    }
}

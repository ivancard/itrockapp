//
//  APIClient+Review.swift
//  Izipark
//
//  Created by Ignacio Arias on 20/03/2023.
//

import Foundation
import UIKit

extension APIClient {
    enum Review {}
}

extension APIClient.Review {
    struct CreateReview: APIRequest {
        typealias ResponseType = Spot

        var spotID: Int?
        var rating: Int?
        var comment: String?

        var method: HTTPMethod { return .post }
        var path: String { "review/create_review" }

        var parameters: [String : Any?]? {
            return [
                "spot_id": spotID,
                "rating": rating,
                "commnet": comment
            ]
        }
    }

    struct GetReviewsBySpot: APIRequest {
        typealias ResponseType = [Spot]

        var spotID : Int?
        var page : Int?

        var method: HTTPMethod { return .get }
        var path: String { "review/get_reviews_by_spot" }

        var parameters: [String : Any?]? {
            return [
                "spot_id": spotID,
                "page": page,
            ]
        }
    }
}

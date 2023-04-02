//
//  APIClient+Legal.swift
//  Izipark
//
//  Created by Ignacio Arias on 20/03/2023.
//

import Foundation
import UIKit

extension APIClient {
    enum Legal {}
}

extension APIClient.Legal {
    struct Terms: APIRequest {
        typealias ResponseType = TermsAndPrivacy

        var method: HTTPMethod { return .get }
        var path: String { "terms" }

        var parameters: [String : Any?]? {
            return nil
        }
    }

    struct Privacy: APIRequest {
        typealias ResponseType = TermsAndPrivacy

        var method: HTTPMethod { return .get }
        var path: String { "privacy" }

        var parameters: [String : Any?]? {
            return nil
        }
    }
}

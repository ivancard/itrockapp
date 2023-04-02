//
//  APIClient.swift
//  Ignite
//
//  Created by Nicolas Bolzan on 12/08/2020.
//  Copyright © 2020 InfinixSoft. All rights reserved.
//

import UIKit
import Combine

struct APIClient {
    
    static var environment: Environment = .dev

    static var BASE_URL: String {
        return environment.rawValue
    }

    enum Environment: String {
        case dev = "https://izipark.xanthops.com/api/v1/"
        case prod = ""
    }
    
}

protocol APIRequest {
    associatedtype ResponseType: Codable
    
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String : String] { get }
    var parameters: [String : Any?]? { get }
    var log: Bool { get }
}

extension APIRequest {
    var method        : HTTPMethod { return .get }
    var parameters    : [String: Any?]? { return nil }
    var headers       : [String: String] { return [:] }
    var log           : Bool { return true }
    
    func dispatch(showError: Bool = true) -> AnyPublisher<ResponseType, Error> {
        
        guard let url = URL(string: path.contains("http") ? path : APIClient.BASE_URL + path) else {
            fatalError("Could not get url")
        }
        
        var params = parameters?.normalized ?? [:]
        
        var urlRequest: URLRequest
        
        if method == .get {
            var components = URLComponents(string: APIClient.BASE_URL + path)!
            
            components.queryItems = params.compactMap { (key, value) in
                URLQueryItem(name: key, value: "\(value ?? "")")
            }
            
            urlRequest = URLRequest(url: components.url!)
            
        } else {
            urlRequest = URLRequest(url: url)
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        urlRequest.httpMethod = method.rawValue
        
        var headers = self.headers
        headers["Content-Type"] = headers["Content-Type"] ?? "application/json"
        
        if let accessToken = User.current?.accessToken {
            headers["Authorization"] = User.current?.accessToken
        }
        
        urlRequest.allHTTPHeaderFields = headers
        
        #if DEBUG
        logRequest(params: params)
        #endif
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                #if DEBUG
                self.logResponse(data: data, response: httpResponse)
                #endif
                
                let viewController = (UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController)?.viewControllers.last as? BaseViewController
                
                guard 200...299 ~= httpResponse.statusCode else {
                    
                    do {
                        let errorDecoder = JSONDecoder()
                        let apiError = try errorDecoder.decode(APIError.self, from: data)
                        
                        if showError {
                            viewController?.showError(apiError)
                        }
                        throw apiError
                        
                    } catch {
                        if showError {
                            viewController?.showError()
                        }
                        throw URLError(.badServerResponse)
                    }
                }
                
                do {
                   let model = try JSONDecoder().decode(ResponseType.self, from: data)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
                return data
            }
            .decode(type: ResponseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

extension Dictionary where Key == String, Value == Any? {
    var normalized: [String: Any?] {
        var normalizedDictionary = [String: Any]()
        for (key, value) in self {
            if let _value = value, _value as? String != "" || !(_value is String) {
                normalizedDictionary[key] = _value
            }
        }
        return normalizedDictionary
    }
}

final class APIError: Error, Codable {
    var code: String?
    var detail: String?
}

final class GenericResponse: Codable {
    var detail: String?
}

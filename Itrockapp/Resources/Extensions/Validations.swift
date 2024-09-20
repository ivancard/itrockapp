//
//  Validations.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 21/03/2023.
//

import UIKit
import Combine
import SkyFloatingLabelTextField

extension UITextField {
    
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
    
    func textPublisher(for types: [PublisherType]) -> Publishers.Map<AnyPublisher<String, Never>, Bool> {
        textPublisher()
            .map { text in
                types.reduce(true) { partialResult, publisherType in
                    switch publisherType {
                    case .notEmpty:
                        return partialResult && !text.isEmpty
                    case .validEmail:
                        return partialResult && text.isValidEmail
                    }
                }
            }
    }
    
    enum PublisherType {
        case notEmpty, validEmail
    }
}

extension SkyFloatingLabelTextField {
    
    func validateLimit(_ count: Int) -> AnyCancellable {

        return textPublisher()
            .map { $0.count > count }
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] isNotValid in
                    if isNotValid { self?.text?.removeLast() }
                })
    }
}

//
//  SizeModal+Extension.swift
//  Izipark
//
//  Created by fabian zarate on 07/02/2023.
//

import Foundation
import UIKit

@available(iOS 15.0, *)
extension UISheetPresentationController.Detent.Identifier {
    static let minSize = UISheetPresentationController.Detent.Identifier("minSize")
    static let maxSize = UISheetPresentationController.Detent.Identifier("maxSize")
    static let zero = UISheetPresentationController.Detent.Identifier("zero")
}


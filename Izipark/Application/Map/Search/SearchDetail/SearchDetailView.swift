//
//  SearchDetailView.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 27/03/2023.
//

import UIKit
import Combine

final class SearchDetailView: DesignableXibView {
            
    let cancelAction = PassthroughSubject<Void, Never>()
    let modifyAction = PassthroughSubject<Void, Never>()
    
    @IBAction private func cancelarBusquedaAction(_ sender: Any) {
        let popup = PopupViewController(
            title: "Cancelar búsqueda",
            subtitle: "¿Estas seguro que deseas cancelar?",
            secondaryButtonItem: .init(title: "No"),
            primaryButtonItem: .init(title: "Cancelar",
                                     action: { [weak self] in
                                         self?.cancelAction.send(())
                                     }))
        
        popup.show()
    }
    
    @IBAction private func modificarBusquedaAction(_ sender: Any) {
        modifyAction.send(())
    }
}

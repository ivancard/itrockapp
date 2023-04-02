//
//  TermsAndConditionsViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 09/03/2023.
//

import UIKit

final class TermsAndConditionsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var text = ""
    var arrayText: [String] = []
    let terms: Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        configureTable()
    }

    init(terms: Bool) {
        self.terms = terms
        
        super.init()
    }
    
    private func configView() {
        tabBarController?.tabBar.isHidden = true
        if terms {
            title = "Términos y Condiciones"
            getTermsAndConditions()
        } else {
            title = "Políticas de Privacidad"
            getPrivacy()
        }
    }
    
    private func splitString() {
        let test = text.components(separatedBy: "Sección")
        self.arrayText = test
        tableView.reloadData()
    }
}

extension TermsAndConditionsViewController {
    private func getTermsAndConditions() {
        loading = true
        
        APIClient.Legal.Terms()
            .dispatch(showError: false)
            .sink(
                receiveCompletion: { [weak self] result in
                    switch result {
                    case .failure:
                        self?.showError("No se pudo obtener los terminos y condiciones.")
                    default: break
                    }
                    
                    self?.loading = false
                },
                receiveValue: { terms in
                    self.text = terms.description ?? ""
                    self.splitString()
                })
            .store(in: &cancellables)
    }
    
    private func getPrivacy() {
        loading = true
        
        APIClient.Legal.Privacy()
            .dispatch(showError: false)
            .sink(
                receiveCompletion: { [weak self] result in
                    switch result {
                    case .failure:
                        self?.showError("No se pudo obtener los terminos y condiciones.")
                    default: break
                    }
                    
                    self?.loading = false
                },
                receiveValue: { privacy in
                    self.text = privacy.description ?? ""
                    self.splitString()
                })
            .store(in: &cancellables)
    }
}

extension TermsAndConditionsViewController: UITableViewDelegate, UITableViewDataSource {
    private func configureTable() {
        tableView.configure(delegate: self, dataSource: self, cells: [TermsTableViewCell.self])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: TermsTableViewCell.self)
        cell.configureCell(text: arrayText[indexPath.row])
        return cell
    }
}

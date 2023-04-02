//
//  SpotSearchView.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/03/2023.
//

import UIKit
import GooglePlaces
import Combine

final class SpotSearchView: DesignableXibView {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @Published private var cachedSuggestions: [SpotSearchResultModel] = []
    
    private let placesFinder = GoogleManager.Places.PlacesFinder()
    
    private var cancellables = Set<AnyCancellable>()
    
    lazy var dataSource = UITableViewDiffableDataSource<Int, SpotSearchResultModel>(tableView: tableView) { [weak self] (tableView, indexPath, model) -> UITableViewCell? in
        let cell = tableView.dequeue(cellType: SearchResultCell.self)
        cell.setup(with: model)
        return cell
    }
    
    weak var delegate: SpotSearchDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Ingresá tu destino aquí...",
            attributes: [.foregroundColor: UIColor.black,
                         .font: UIFont.Poppins.regular(withSize: 14)]
        )
        
        tableView.register(cellType: SearchResultCell.self)
        tableView.delegate = self
        
        dataSource.defaultRowAnimation = .top
        bind()
    }
    
    private func bind() {
        $cachedSuggestions
            .sink(receiveValue: { [weak self] suggestions in
                self?.tableView.isHidden = suggestions.isEmpty
                
                var snapshot = NSDiffableDataSourceSnapshot<Int, SpotSearchResultModel>()
                snapshot.appendSections([1])
                snapshot.appendItems(suggestions, toSection: 1)
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            })
            .store(in: &cancellables)
        
        searchTextField.textPublisher()
            .assign(to: \.keyword, on: placesFinder)
            .store(in: &cancellables)
        
        placesFinder.$predictions
            .sink { [weak self] predictions in
                self?.cachedSuggestions = predictions.map {
                    return SpotSearchResultModel(
                        placeID: $0.placeID,
                        title: $0.attributedPrimaryText.string,
                        subtitle: $0.attributedSecondaryText?.string,
                        isFirst: true)
                }
            }
            .store(in: &cancellables)
    }
    
    private func getInfo(for placeID: String) {
        placesFinder.getInfo(for: placeID)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] place in
                    self?.select(place)
                })
            .store(in: &cancellables)
    }
    
    private func select(_ place: GMSPlace) {
        let searchLocation = SearchLocation(name: place.name,
                                            address: place.formattedAddress,
                                            coordinate: place.coordinate)
        
        SearchLocation.current = searchLocation
        
        cachedSuggestions = []
        delegate?.didSelectLocation()
    }
}

extension SpotSearchView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeID = cachedSuggestions[indexPath.row].placeID
        getInfo(for: placeID)
    }
}

protocol SpotSearchDelegate: AnyObject {
    func didSelectLocation()
}

struct SpotSearchResultModel: Hashable {
    let placeID: String
    let title: String?
    let subtitle: String?
    let isFirst: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(placeID)
    }
    
    static func == (lhs: SpotSearchResultModel, rhs: SpotSearchResultModel) -> Bool {
        lhs.placeID == rhs.placeID
    }
}

//
//  SetPrestadorLocationViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 12/01/2023.
//

import UIKit
import MapboxMaps
import MapboxSearch

final class SetPrestadorLocationViewController: BaseViewController {

    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var searchTextField: MyTextField!
    
    let searchEngine = SearchEngine()
    internal var mapView: MapView!
    private let FIRST_RESULT = 0
    
    private var searchSuggestion = [MapboxSearch.SearchSuggestion]() {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.resultsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavItems()
        initMap()
        configTableView()
        setSearchTextField()
        searchEngine.delegate = self
    }
    
    private func setSearchTextField() {
        searchTextField.leftViewMode = .always
        let textFieldIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25 ))
        var image = UIImage(systemName: "magnifyingglass")
        image = image?.withTintColor(UIColor(named: "Disabled") ?? .gray, renderingMode: .alwaysOriginal)
        textFieldIcon.setImage(image, for: .normal)
        textFieldIcon.isEnabled = false
        textFieldIcon.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -16)
        
        searchTextField.leftView = textFieldIcon
    }
    
    private func initMap() {
        let mapView = MapHelper.getMap(frame: mapContainer.bounds)
        mapView.layer.cornerRadius = 8
        mapView.clipsToBounds = true
        self.mapContainer.insertSubview(mapView, at: 0)
        searchTextField.delegate = self
        mapView.location.delegate = self
        mapView.location.locationProvider.startUpdatingLocation()
    }
    
    func configTableView(){
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        let cell = UINib(nibName: SearchResultCell.identifier, bundle: nil)
        resultsTableView.register(cell, forCellReuseIdentifier: SearchResultCell.identifier)
    }
    
    func searchLocationSpot(searchLocation : CLLocationCoordinate2D) {
        print("hola: \(searchLocation)")
    }
    
    @IBAction func continueButton(_ sender: Any) {
//        self.navigationController?.pushViewController(AvailabilityPrestadorRegisterViewController(), animated: true)
    }
    
    func setNavItems(){
        let skipButton = UIBarButtonItem(title: "Saltar", style: .plain, target: self, action: nil)
        navigationItem.setRightBarButton(skipButton, animated: true)
    }
}

extension SetPrestadorLocationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchSuggestion.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as? SearchResultCell else {
            return UITableViewCell()
        }
//        if indexPath.row == FIRST_RESULT {
//            cell.changeNameColorBlack()
//        } else {
//            cell.changeNameColorGray()
//        }
//
//        cell.setUpResultSearch(result: searchSuggestion[indexPath.row])
//
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchEngine.select(suggestion: searchSuggestion[indexPath.row])
        
        self.searchTextField.text = searchSuggestion[indexPath.row].name
        UIView.animate(withDuration: 0.5, animations: {
            tableView.isHidden = true
        })
    }
}

extension SetPrestadorLocationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        textField.text = updatedString
        
        updatedString = updatedString?.trimmingCharacters(in: .whitespaces)
        if updatedString == ""
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.resultsTableView.isHidden = true
            })
        }else{
            self.searchEngine.query = updatedString ?? ""
            UIView.animate(withDuration: 0.5, animations: {
                self.resultsTableView.isHidden = false
            })
        }
        
        return false
    }
}

extension SetPrestadorLocationViewController: LocationPermissionsDelegate, LocationConsumer {
    
    func locationUpdate(newLocation: MapboxMaps.Location) {
        mapView.camera.fly(to: CameraOptions(center: newLocation.coordinate, zoom: 14.0), duration: 5.0)
    }
}

extension SetPrestadorLocationViewController: SearchEngineDelegate {
    
    func suggestionsUpdated(suggestions: [MapboxSearch.SearchSuggestion], searchEngine: MapboxSearch.SearchEngine) {
       
        self.searchSuggestion = suggestions
    }
    
    func resultResolved(result: SearchResult, searchEngine: SearchEngine) {
        
        let searchLocation = SearchLocation(
            name: result.name,
            address: result.address?.formattedAddress(style: .medium),
            coordinate: result.coordinate)
        
        print("Save searchLocation in UserDeafaults")
        SearchLocation.current = searchLocation
        
    }
    
    func searchErrorHappened(searchError: MapboxSearch.SearchError, searchEngine: MapboxSearch.SearchEngine) {
        print("Error during search: \(searchError)")
    }
}

class MyTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

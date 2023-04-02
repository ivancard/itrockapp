//
//  HomeMapViewController.swift
//  Izipark
//
//  Created by fabian zarate on 23/01/2023.
//

import UIKit
import MapboxMaps

final class HomeMapViewController: NavigationDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchView: SpotSearchView!
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: IziMap!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesNavigationBar = true
        
        collectionView.configure(delegate: self, dataSource: self, cells: [SpotMapCollectionViewCell.self])
        
        searchView.delegate = self
        mapView.delegate = self
        mapView.directions = viewModel.direcciones
        
        bind()
    }
    
    override init(nibName: String? = nil) {
        super.init(nibName: nibName)
        configItemTabBar(nameTitle: "Mapa", image: UIImage.iconMap!)
    }
    
    private func bind() {
        viewModel.navigationViewController
            .sink(receiveValue: { [weak self] controller in
                controller.delegate = self
                self?.present(controller, animated: true)
            })
            .store(in: &cancellables)
    }
}

extension HomeMapViewController: IziMapDelegate {
    func showSpotDetails(_ show: Bool, at index: Int?) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.collectionView.isHidden = !show
        })
        
        if let item = index {
            collectionView.selectItem(at: .init(item: item, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}

extension HomeMapViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.direcciones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: SpotMapCollectionViewCell.self, at: indexPath)
        
        cell.BtnGoToTheSpot.setTitle("Estacionar aquí", for: [])
        
        cell.seeMoreAction = { [weak self] in
            self?.navigationController?.pushViewController(SpotDetailViewController(), animated: true)
        }
        
        cell.goToTheSpot = { [weak self] in
            let location = self?.viewModel.direcciones[indexPath.row]
            SearchLocation.current = .init(name: "Spot",
                                           address: nil,
                                           coordinate: location)
            self?.didSelectLocation()
        }
        
        cell.spotDisponible = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32,
                      height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let item = scrollView.currentPage
        let selected = viewModel.direcciones[item]
        
        mapView.map.camera.fly(to: CameraOptions(center: selected, zoom: 14.0), duration: 1)
    }
}

extension HomeMapViewController: SpotSearchDelegate {
    func didSelectLocation() {
        let vc = ResultadoBusquedaViewController()
        present(vc, animated: true, embedNavigation: true)
    }
}

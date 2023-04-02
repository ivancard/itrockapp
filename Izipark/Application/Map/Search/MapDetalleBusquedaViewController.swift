//
//  MapDetalleBusquedaViewController.swift
//  Izipark
//
//  Created by fabian zarate on 03/02/2023.
//

import UIKit
import MapboxMaps

final class MapDetalleBusquedaViewController: NavigationDelegate {
    
    @IBOutlet weak var mapView: IziMap!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchDetail: SearchDetailView!
    @IBOutlet weak var searchDetailBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionBottomConstraint: NSLayoutConstraint!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesNavigationBar = true
        
        mapView.delegate = self
        mapView.directions = viewModel.direcciones
                
        collectionView.configure(
            delegate: self,
            dataSource: self,
            cells: [SpotMapCollectionViewCell.self])
        
        let detailRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detailPanGestureRecognizerHandler(_:)))
        detailRecognizer.delegate = self
        searchDetail.addGestureRecognizer(detailRecognizer)
        
                let collectionRecognizer = UIPanGestureRecognizer(target: self, action: #selector(collectionPanGestureRecognizerHandler(_:)))
                collectionRecognizer.delegate = self
                collectionView.addGestureRecognizer(collectionRecognizer)
        
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.addCircleAnnotation()
    }
    
    private func bind() {
        searchDetail.cancelAction
            .sink {
                NavigationHelper.enterApp()
            }
            .store(in: &cancellables)
        
        searchDetail.modifyAction
            .sink { [weak self] in
                let vc = TodoListoBusquedaViewController(edit: true)
                let nc = UINavigationController(rootViewController: vc)
                nc.modalPresentationStyle = .fullScreen
                self?.present(nc, animated: true)
            }
            .store(in: &cancellables)
        
        viewModel.navigationViewController
            .sink(receiveValue: { [weak self] controller in
                controller.delegate = self
                self?.present(controller, animated: true)
            })
            .store(in: &cancellables)
        
    }
    
    @IBAction func spotListAction(_ sender: Any) {
        let vc = SpotsDisponiblesViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true)
    }
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var verticalPosition: CGFloat = 0
    
    @objc func collectionPanGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        gestureAction(gesture: sender,
                      bottomConstraint: collectionBottomConstraint,
                      defaultValue: 20)
    }
    
    @objc func detailPanGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        gestureAction(gesture: sender,
                      bottomConstraint: searchDetailBottomConstraint,
                      minHeight: 70)
    }
    
    private func gestureAction(gesture sender: UIPanGestureRecognizer, bottomConstraint: NSLayoutConstraint, minHeight: CGFloat = 0, defaultValue: CGFloat = 0) {
        guard let gestureView = sender.view else { return }
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == .began {
            initialTouchPoint = touchPoint
        } else if sender.state == .changed {
            UIView.animate(withDuration: 0, animations: { [weak self] in
                guard let self = self else { return }
                if sender.velocity(in: self.view).y > 0 {
                    bottomConstraint.constant = -(touchPoint.y - self.initialTouchPoint.y)
                } else if bottomConstraint.constant < defaultValue {
                    bottomConstraint.constant = -(gestureView.frame.height - minHeight) - (touchPoint.y - self.initialTouchPoint.y)
                }
                self.view.layoutIfNeeded()
            })
        } else if sender.state == .ended || sender.state == .cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 || sender.velocity(in: view).y > 50 {
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    guard let self = self else { return }
                    bottomConstraint.constant = -(gestureView.frame.height - minHeight)
                    self.view.layoutIfNeeded()
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    guard let self = self else { return }
                    bottomConstraint.constant = defaultValue
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
}

extension MapDetalleBusquedaViewController: IziMapDelegate {
    func showSpotDetails(_ show: Bool, at index: Int?) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.collectionBottomConstraint.constant = 20
            self.view.layoutIfNeeded()
        })
        
        if let item = index {
            collectionView.selectItem(at: .init(item: item, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
}

extension MapDetalleBusquedaViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.direcciones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: SpotMapCollectionViewCell.self, at: indexPath)
        
        cell.seeMoreAction = { [weak self] in
            self?.navigationController?.pushViewController(SpotDetailViewController(), animated: true)
        }
        
        cell.goToTheSpot = { [weak self] in
            let vc = BuscandoMejorSpotViewController(text: ["Calculando ruta..."]) { [weak self] in
                guard let self = self else { return }
                
                let location = self.viewModel.direcciones[indexPath.row]
                let userLocation = self.mapView.map.location.latestLocation
                self.viewModel.requestRoute(destinationSpot: location, userLocation: userLocation)
            }
            
            self?.present(vc, animated: true)
            
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

extension MapDetalleBusquedaViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
            if gestureRecognizer.numberOfTouches > 0 {
                let translation = panGesture.velocity(in: collectionView)
                return abs(translation.y) > abs(translation.x)
            } else {
                return false
            }
        }
        return true
    }
}

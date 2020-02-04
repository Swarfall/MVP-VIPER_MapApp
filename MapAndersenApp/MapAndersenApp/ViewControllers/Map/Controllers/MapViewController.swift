//
//  MapViewController.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 27.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol MapViewProtocol {
    
}

class MapViewController: UIViewController, MapViewProtocol {

    //MARK: - IBOutlet private property
    @IBOutlet private weak var mapView: GMSMapView!
    
    //MARK: - Private properties
    private var presenter: MapPresenterProtocol?
    private var locationManager = CLLocationManager()
    private let infoView = InfoView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    
    //MARK: - Public properties
    var users: [UserViewModel] = []
    
    //MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapPresenter(users: users)
        presenter?.view = self
        updateDataMarkersLocation()
    }
    
    //MARK: - Private funcs
    private func updateDataMarkersLocation() {
        updatesMarkers()
        setCurrentLocation()
    }
    
    private func updatesMarkers() {
        guard let presenter = presenter else { return }
        let coordinates = presenter.markersLocation()
        let userInfo = presenter.userInfo()
        var pinData = PinDataEntity()
        for (index, element) in coordinates.enumerated() {
            let marker = GMSMarker()
            marker.position.latitude = element.latitude
            marker.position.longitude = element.longitude

            if element.latitude == userInfo[index].lat && element.longitude == userInfo[index].long {
                pinData.name = userInfo[index].name
                pinData.surname = userInfo[index].surname
                pinData.large = userInfo[index].large
            }
            marker.userData = pinData
            marker.map = mapView
        }
    }
    
    private func setCurrentLocation() {
        locationManager.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        guard let userInfo = marker.userData as? PinDataEntity else { return nil }
        let view = InfoView(frame:  .init(x: 0, y: 0, width: 200, height: 100))
        view.update(user: userInfo)
        return view
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let stb = UIStoryboard(name: "InfoUser", bundle: nil)
        guard let vc = stb.instantiateViewController(withIdentifier: String(describing: InfoUserViewController.self)) as? InfoUserViewController else { return }
        guard let userInfo = marker.userData as? PinDataEntity else { return }
        vc.imageName = userInfo.large
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let presenter = presenter else { return }
        let camera = GMSCameraPosition.camera(withLatitude: presenter.cameraPosition().lat,
                                              longitude: presenter.cameraPosition().long,
                                              zoom: Float(presenter.cameraPosition().zoom))
        mapView.animate(to: camera)
        locationManager.stopUpdatingLocation()
    }
}

//
//  MapPresenter.swift
//  MapAndersenApp
//
//  Created by Вячеслав Савицкий on 27.01.2020.
//  Copyright © 2020 Вячеслав Савицкий. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

protocol MapPresenterProtocol {
    var view: MapViewProtocol? { get set }
    var users: [UserViewModel] { get set }
    func markersLocation() -> ([CLLocationCoordinate2D])
    func cameraPosition() -> (lat: Double, long: Double, zoom: Double)
    func userInfo() -> [UserViewModel]
    func model(index: Int) -> UserViewModel
}

class MapPresenter {
    //MARK: - Init
    init(users: [UserViewModel]) {
        self.users = users
    }
    
    //MARK: - Protocol properties
    var view: MapViewProtocol?
    var users: [UserViewModel] = []
    
    //MARK: - Private properties
    private var locationManager = CLLocationManager()
}

//MARK: - Protocol funcs
extension MapPresenter: MapPresenterProtocol {
    func model(index: Int) -> UserViewModel {
        return users[index]
    }
    
    func userInfo() -> [UserViewModel] {
        return users
    }
    
    func markersLocation() -> [CLLocationCoordinate2D] {
        return users.map { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long) }
    }
    
    func cameraPosition() -> (lat: Double, long: Double, zoom: Double) {
        return (users[0].lat, users[0].long, 6.0)
    }
}



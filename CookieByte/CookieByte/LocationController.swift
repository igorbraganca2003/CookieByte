//
//  LocationController.swift
//  CookieByte
//
//  Created by Igor Bragança Toledo on 09/07/24.
//

import Foundation
import MapKit
import CoreLocation

class LocationController: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var userLocation: CLLocation?
    static let locationShared = LocationController()
    let locationManager = CLLocationManager()
    @Published var inOrOut: Bool = false
    
    // Defina a localização de referência e o raio em metros
    let mackenzieLocation = CLLocation(latitude: -23.547193800000002, longitude: -46.652463102705724)
    let radius: Double = 1000.0 // Raio em metros
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocalization() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func distance(from location: CLLocation) -> CLLocationDistance? {
        if let userLocation = userLocation {
            return userLocation.distance(from: location)
        }
        return nil
    }
    
    // Delegate methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
        
        if let distance = distance(from: mackenzieLocation), distance < radius {
            // Enviar notificação ou realizar ação necessária
            print("Usuário está dentro do raio de 1000 metros do Mackenzie.")
            inOrOut = true
        } else {
            print("Usuário está fora do raio de 1000 metros do Mackenzie.")
            inOrOut = false
        }
    }
}

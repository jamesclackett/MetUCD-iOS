//
//  MapViewModel.swift
//  MetUCD
//
//  Created by James Clackett on 18/11/2023.
//

import MapKit
import SwiftUI

/// An Observable View Model that represents and contains relevant data for the application's MapView.
/// Contains three important variables - the user location, the selected location, and the map center,
/// Is a Delegate for the CLLocation Object used in the application
///
/// Note: there is unexpected behaviour occuring as a result of this class.
/// State is being updated multiple times and as a result is cauing multiple reloads of the Observing Views.
/// This is leading to a bug with the weather annotation where when a new location is selected (by touch) the temperature
/// value is updated correctly but then reverted to the previous again.
@Observable
class MapViewModel: NSObject, CLLocationManagerDelegate {
    
    /// An instance of WeatherViewModel, used for getting forecast information.
    var weatherViewModel = WeatherViewModel()

    /// The CLLlocationManager Object used to find and update the user's current location.
    var locationManager: CLLocationManager?

    // A map camera position for the Map's center
    var mapCenter = MapCameraPosition.region(MKCoordinateRegion(center: MapDefaults.location, span: MapDefaults.span))
    
    // A map camera position for the user's location.
    var userLocation: MapCameraPosition {
        MapCameraPosition.region(MKCoordinateRegion(center: locationManager?.location?.coordinate ?? MapDefaults.location, span: MapDefaults.span))
    }
    
    /// The selected location coordinate.
    /// On Set, updates the map center and viewmodel location accordingly.
    /// As MapCenter and weatherViewModel are already observed, I have set  this property to @ObservationIgnored.
    @ObservationIgnored
    var selectedLocation: CLLocationCoordinate2D = MapDefaults.location {
        didSet {
            weatherViewModel.newLocation(lat: selectedLocation.latitude, lon: selectedLocation.longitude)
            mapCenter = MapCameraPosition.region(MKCoordinateRegion(center: selectedLocation, span: MapViewModel.MapDefaults.span))
        }
    }
    
    /// Confrms that location services are enabled on the device itself.
    /// If allowed, sets the location manager and sets the current class (MapViewModel) as its delegate.
    /// If not allowes, prints warning to sysot and returns a false completion.
    func confirmLocationServicesEnabled(completion: @escaping (Bool) -> Void) {
            DispatchQueue.global().async {
                if CLLocationManager.locationServicesEnabled() {
                    DispatchQueue.main.async {
                        self.locationManager = CLLocationManager()
                        self.locationManager?.delegate = self
                        completion(true)
                    }
                } else {
                    print("location must be enabled to use all the features of this app.")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        }
    
    /// Confrims that the appliation  has been granted location service privileges.
    /// If services granted, sets the map location to user location
    /// If services denied, prints alert to sysout.
    func confirmLocationAuthorized() {
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Alert: location is restricted on this device.")
        case .denied:
            print("Alert: location services denied - set to default of Dublin, Ireland.")
        case .authorizedAlways, .authorizedWhenInUse:
            selectedLocation = locationManager.location?.coordinate ?? MapDefaults.location
        @unknown default:
            break
        }
    }
    
    /// Called if CLLocationManager detects that the device location has changed.
    /// Calls confirmLocationAuthorized to update location if the application has been granted location services.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        confirmLocationAuthorized()
    }

}

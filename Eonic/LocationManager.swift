//
//  LocationManager.swift
//  Eonic
//
//  Created by Yuri Spaziani on 04/03/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

import Foundation
import CoreLocation
import UserNotifications
import UIKit

let locationManager = LocationManager.getLocationManager()

class LocationManager: NSObject, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    static let singleton = LocationManager()
    static func getLocationManager() -> LocationManager{
        return .singleton
    }
    
    var lastposition = CLLocation()
    
    private override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.allowsBackgroundLocationUpdates = true
        DispatchQueue.main.async {
            //            self.locationManager.startUpdatingLocation()
            //            self.locationManager.startMonitoringVisits()
            self.locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let distance = lastposition.distance(from: locations.last!)
        
        if (UIApplication.shared.applicationState == .inactive || UIApplication.shared.applicationState == .background){
            if (distance > 25000){
                lastposition = locations.last!
                let center = UNUserNotificationCenter.current()
                let content = UNMutableNotificationContent()
                content.title = NSLocalizedString("Charger Found", comment: "Charger-Found")
                content.body =  NSLocalizedString("Click here to go to the nearest Ev Charger", comment: "Go-to-nearest")
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                
                let identifier = "EVChargerInArea"
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                center.add(request) { (error) in
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

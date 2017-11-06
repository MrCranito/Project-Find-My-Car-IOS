//
//  ViewController.swift
//  Where_is_my_car
//
//  Created by Maxime Guisset on 15/04/2017.
//  Copyright © 2017 Maxime Guisset. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    private var locManager: CLLocationManager?
    @IBOutlet weak var map: MKMapView!
    private var currentLocation: CLLocation?

    private var canLocate: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canLocate = true
        
        //self.navigationController?.isNavigationBarHidden = true
        
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        
        if !CLLocationManager.locationServicesEnabled(){ //Location disabled in settings
            showPopup()
            canLocate = false
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first!
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation!.coordinate, 5000, 5000)
        map.setRegion(coordinateRegion, animated: true)
        locManager!.stopUpdatingLocation()
        locManager = nil
    }
    
    @IBAction func saveTap(_ sender: Any) {
        if canLocate!{
            let add = self.storyboard?.instantiateViewController(withIdentifier: "AddView") as! AddViewController
            let altitude = currentLocation!.altitude
            let latitude = currentLocation!.coordinate.latitude
            let longitude = currentLocation!.coordinate.longitude
        
            
            add.altitudeValue = String(altitude)
            add.longitudeValue = String(longitude)
            add.latitudeValue = String(latitude)
            
            self.navigationController?.pushViewController(add, animated: true)
        }
        else{
            showPopup()
        }
    }
    
    @IBAction func returnTap(_ sender: Any) {
        let locations = self.storyboard?.instantiateViewController(withIdentifier: "TableView") as! TableViewController
        self.navigationController?.pushViewController(locations, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .restricted || status == .denied{
            showPopup()
            canLocate = false
        }
        else{
            map.showsUserLocation = true
            locManager!.startUpdatingLocation()
        }
        
    }
    
    private func showPopup(){
        let popup:UIAlertController = UIAlertController(title: "Error", message: "We need the permission to access your location", preferredStyle: UIAlertControllerStyle.alert)
        
        let action : UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            popup.dismiss(animated: true, completion: nil)
        }
        
        popup.addAction(action)
        
        self.navigationController?.present(popup, animated: true, completion: nil)
    }
}


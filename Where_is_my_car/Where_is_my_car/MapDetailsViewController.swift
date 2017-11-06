//
//  MapDetailsViewController.swift
//  Where_is_my_car
//
//  Created by Maxime Guisset on 16/04/2017.
//  Copyright © 2017 Maxime Guisset. All rights reserved.
//

import UIKit
import MapKit

class MapDetailsViewController: UIViewController{
    public var location: Location?
    @IBOutlet weak var map: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.showsUserLocation = true
        
        self.title = "Location"

        let mapPosition = CLLocationCoordinate2D(latitude: CLLocationDegrees(Float(location!.latitude!)!), longitude: CLLocationDegrees(Float(location!.longitude!)!))
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = mapPosition
        map.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapPosition, 5000, 5000)
        map.setRegion(coordinateRegion, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

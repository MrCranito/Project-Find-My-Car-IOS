//
//  DetailsViewController.swift
//  Where_is_my_car
//
//  Created by Maxime Guisset on 16/04/2017.
//  Copyright © 2017 Maxime Guisset. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var commentLabel: UILabel!
    
    public var location: Location?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        
        name.text = location!.name
        latitude.text = "Latitude : \(location!.latitude!)"
        longitude.text = "Longitude : \(location!.longitude!)"
        altitude.text = "Altitude : \(location!.altitude!) meters"
        
        comment.isEditable = false
        
        if location!.comment != ""{
            comment.text = location!.comment
            //let commentSplit = location!.comment?.components(separatedBy: "\n")
        }
        else{
            //comment.text = "/" //No comment
        }
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showLocation(_ sender: Any) {
        let mapDetails = self.storyboard?.instantiateViewController(withIdentifier: "MapDetailsView") as! MapDetailsViewController
        
        mapDetails.location = location
        
        self.navigationController?.pushViewController(mapDetails, animated: true)
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

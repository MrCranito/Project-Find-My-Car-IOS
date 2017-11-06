//
//  AddViewController.swift
//  Where_is_my_car
//
//  Created by Maxime Guisset on 16/04/2017.
//  Copyright © 2017 Maxime Guisset. All rights reserved.
//

import UIKit

extension UINavigationController{ //Disable lock rotation
    override open var shouldAutorotate: Bool{
        get{
            return false
        }
    }
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return UIInterfaceOrientationMask.portrait
        }
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    
    public var altitudeValue: String?
    public var longitudeValue: String?
    public var latitudeValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.delegate = self
        self.comment.delegate = self
        
        self.title = "Save"
        
        name.layer.borderWidth = 1
        comment.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        comment.layer.borderColor = UIColor.black.cgColor
        
        altitude.text = "Altitude : " + altitudeValue! + " meters"
        longitude.text = "Longitude : " + longitudeValue!
        latitude.text = "Latitude : " + latitudeValue!
        
        self.hideKeyboard()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSave(_ sender: Any) {
        var valid = true
        name.layer.borderColor = UIColor.black.cgColor
        comment.layer.borderColor = UIColor.black.cgColor
        
        if name.text!.characters.count > 30 || !name.hasText{
            valid = false
            name.layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        }
        
        if comment.text!.characters.count > 100 {
            valid = false
            comment.layer.borderColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        }
        
        if valid{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let location = Location(context: context) // Link Task & Context
            
            location.name = name.text!
            location.altitude = altitudeValue!
            location.longitude = longitudeValue!
            location.latitude = latitudeValue!
            location.comment = comment.text!
            
            // Save the data to coredata
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            let popup:UIAlertController = UIAlertController(title: "Confirmation", message: "The location has successfully been saved !", preferredStyle: UIAlertControllerStyle.alert)
            
            let action1 : UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                self.navigationController!.popViewController(animated: true)
            }
            
            popup.addAction(action1)
            
            self.navigationController?.present(popup, animated: true, completion: nil)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    /*func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

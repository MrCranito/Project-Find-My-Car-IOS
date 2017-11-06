//
//  TableViewController.swift
//  Where_is_my_car
//
//  Created by Maxime Guisset on 16/04/2017.
//  Copyright © 2017 Maxime Guisset. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    @IBOutlet var table: UITableView!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var locations: [Location] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Locations"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isNavigationBarHidden = false
        
        getData()
        table.reloadData()
    }
    
    private func getData() {
        do {
            locations = try context.fetch(Location.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath) //Create reusable cell
        
        cell.textLabel?.text = locations[indexPath.row].name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.minimumPressDuration = 1.0 //seconds
        cell.addGestureRecognizer(longPress)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsView") as! DetailsViewController
        
        details.location = locations[indexPath.row]
        
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func handleLongPress(_ press : UILongPressGestureRecognizer){
        if press.state == UIGestureRecognizerState.began{
            let point: CGPoint = press.location(in: table)
            let index = table.indexPathForRow(at: point)
            
            let popup:UIAlertController = UIAlertController(title: "Confirmation", message: "Do you really want to delete this location ?", preferredStyle: UIAlertControllerStyle.alert)
        
            let action1 : UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
            }
            
            let action2 : UIAlertAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                
                let loc = self.locations[index!.row] //Delete from DB
                self.context.delete(loc)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                self.locations.remove(at: index!.row) //Delete from data array
                self.table.deleteRows(at: [index!], with: UITableViewRowAnimation.none) //Delete from UITableView
            }
            
            popup.addAction(action1)
            popup.addAction(action2)
            
            self.navigationController?.present(popup, animated: true, completion: nil)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

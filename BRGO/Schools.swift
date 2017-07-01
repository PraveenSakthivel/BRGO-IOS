//
//  Schools.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/5/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class Schools: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var Tables: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
           Tables.separatorColor = Colors.tertiary
        let background = UIView()
        background.tintColor = Colors.primary
        Tables.tableFooterView = background
        
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

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        if let label = cell.textLabel { //Insert the names of your school shere
            switch (indexPath as NSIndexPath).row {
            case 0:
                label.text = "High School"
            case 1:
                label.text = "Middle School"
            case 2:
                label.text = "Hillside"
            case 3:
                label.text = "Eisenhower"
            case 4:
                label.text = "Van Holten"
            case 5:
                label.text = "Milltown"
            case 6:
                label.text = "J.F.K. Primary"
            case 7:
                label.text = "Hamilton"
            case 8:
                label.text = "Crim Primary"
            case 9:
                label.text = "Bradely Gardens"
            case 10:
                label.text = "Adamsville"
            default:
                label.text = "Error"
            }
            if (indexPath.row == getToBeChecked())
            {
                cell.accessoryType = .checkmark
            }
            else{
                cell.accessoryType = .none
            }

        }
        cell.backgroundColor = Colors.primary
        cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 16)
        cell.textLabel!.textColor = Colors.secondary
        return cell    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        Tables.deselectRow(at: indexPath, animated:true)
        switch (indexPath as NSIndexPath).row {
        case 0:
            defaults.set(14273, forKey: "School")
        case 1:
            defaults.set(14276, forKey: "School")
        case 2:
            defaults.set(14274, forKey: "School")
        case 3:
            defaults.set(14271, forKey: "School")
        case 4:
            defaults.set(14278, forKey: "School")
        case 5:
            defaults.set(14277, forKey: "School")
        case 6:
            defaults.set(14275, forKey: "School")
        case 7:
            defaults.set(14272, forKey: "School")
        case 8:
            defaults.set(14269, forKey: "School")
        case 9:
            defaults.set(14268, forKey: "School")
        case 10:
            defaults.set(14264, forKey: "School")
        default:
            defaults.set(14273, forKey: "School")
        }
        let alert = UIAlertController(title: "Default Changed", message: "", preferredStyle:  UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        Tables.reloadData()
    }
    func getToBeChecked() -> Int { //Returns the correct OnCourse shool code for the corresponding tablecell
        let defaults = UserDefaults.standard
        switch (defaults.integer(forKey: "School")) {
        case 14273:
            return 0
        case 14276:
            return 1
        case 14274:
            return 2
        case 14271:
            return 3
        case 14278:
            return 4
        case 14277:
            return 5
        case 14275:
            return 6
        case 14272:
            return 7
        case 14269:
            return 8
        case 14268:
            return 9
        case 14264:
            return 10
        default:
            return 0
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

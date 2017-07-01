//
//  Menu.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/19/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class Menu: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let background = UIView()
        background.backgroundColor = Colors.secondary
        self.tableView.tableFooterView = background
        self.tableView.separatorColor = Colors.tertiary
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
        return 8
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch (indexPath as NSIndexPath).row {
            case 0:
            cell.textLabel?.text = "BRGO"
            case 1:
            cell.textLabel?.text = "News"
            case 2:
            cell.textLabel?.text = "Calendar"
            case 3:
            cell.textLabel?.text = "Websites"
            case 4:
            cell.textLabel?.text = "School Handbook"
            case 5:
            cell.textLabel?.text = "Homework Planner"
            case 6:
            cell.textLabel?.text = "Student ID"
            case 7:
            cell.textLabel?.text = "Settings"
            default:
            cell.textLabel?.text = "BRGO"
        }
        if (indexPath as NSIndexPath).row > 0
        {
        cell.backgroundColor = Colors.secondary
        cell.textLabel!.textColor = Colors.primary
        }
        else{
            cell.backgroundColor = Colors.primary
            cell.textLabel?.textColor = Colors.secondary
        }
        cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 16)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated:true)
        switch (indexPath as NSIndexPath).row {
        case 0:
        print("")
        case 1:
        performSegue(withIdentifier: "MenuNews", sender:self)
        case 2:
        performSegue(withIdentifier: "MenuCalendar", sender:self)
        case 3:
        performSegue(withIdentifier: "menuWeb", sender:self)
        case 4:
        performSegue(withIdentifier: "menuHandbook", sender:self)
        case 5:
        performSegue(withIdentifier: "menuPlanner", sender:self)
        case 6:
        performSegue(withIdentifier: "menuID", sender:self)
        case 7:
        performSegue(withIdentifier: "menuSettings", sender:self)
        default:
        performSegue(withIdentifier: "MenuNews", sender:self)
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

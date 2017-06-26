//
//  TodayViewController.swift
//  SavedTeachersShortcut
//
//  Created by Praveen Sakthivel on 11/13/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var ViewWindow: UIView!
    @IBOutlet var Table: UITableView!
    var data = [String]()
    var isClickable = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.init(suiteName: "group.BRGO.data")
        if (defaults?.bool(forKey: "isData"))!
        {
            data = (defaults?.stringArray(forKey: "TeachNames"))!
        }
        else{
            data.append("No Teachers Saved")
            isClickable = false
        }        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0,right: 0)
    }
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        let defaults = UserDefaults.init(suiteName: "group.BRGO.data")
        if (defaults?.bool(forKey: "isData"))!
        {
            data = (defaults?.stringArray(forKey: "TeachNames"))!
        }
        else{
            data.append("No Teachers Saved")
            isClickable = false
        }
        completionHandler(NCUpdateResult.newData)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isClickable){
            let url = NSURL.init(string: "BRGO://T\(indexPath.row)")
            //self.extensionContext?.open(url as! URL, completionHandler: nil)
        }
        Table.deselectRow(at: indexPath, animated: true)
    }
}

//
//  FullCalendar.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/7/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit
//The view that expands when you click on an item in CalendarController
class FullCalendar: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var info: newsarticle = newsarticle()

    @IBOutlet var titlebox: UITableViewCell!
    @IBOutlet var Desc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Desc.text = info.description
        titlebox.textLabel!.text = info.title
        Desc.backgroundColor = Colors.primary
        Desc.textColor = Colors.secondary
        Desc.font = UIFont(name:"Bodoni 72", size: 16)
        self.view.backgroundColor = Colors.primary
        titlebox.backgroundColor = Colors.secondary
        titlebox.textLabel!.font = UIFont(name:"Bodoni 72", size: 22)
        titlebox.textLabel!.textColor = UIColor.white
        titlebox.textLabel!.numberOfLines = 2
        titlebox.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell.textLabel?.text = info.title
        cell.backgroundColor = Colors.secondary
        cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 22)
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.numberOfLines = 2
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        return cell    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


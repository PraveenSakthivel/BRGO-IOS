//
//  SettingsController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/6/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var Tables: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
   Tables.separatorColor = Colors.tertiary
        let background = UIView()
        background.tintColor = Colors.primary
        Tables.tableFooterView = background
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
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
        return 2
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
        if((indexPath as NSIndexPath).row == 0)
        {
            cell.textLabel!.text = "Schools"
        }
        else{
            cell.textLabel!.text = "About"
        }
        cell.backgroundColor = Colors.primary
        cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 16)
        cell.textLabel!.textColor = Colors.secondary
        return cell    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Tables.deselectRow(at: indexPath, animated:true)
       if((indexPath as NSIndexPath).row == 0)
       {
        performSegue(withIdentifier: "Schools", sender:self)
        }
       else{
        performSegue(withIdentifier: "About", sender:self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  FullNews.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/7/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit
//view that expands when you click on an item in NewsController
class FullNews: UIViewController {
    var info: newsarticle = newsarticle()

    @IBOutlet var titlebox: UITableViewCell!
    @IBOutlet var Desc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       Desc.text = info.description
        titlebox.textLabel?.text = info.title
        //titlebox.separatorColor = Colors.tertiary
        Desc.text = info.description
        Desc.backgroundColor = Colors.primary
        Desc.textColor = Colors.secondary
        Desc.font = UIFont(name:"Bodoni 72", size: 16)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

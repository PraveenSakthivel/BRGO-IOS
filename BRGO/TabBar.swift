//
//  TabBar.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/14/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tintColor = UIColor.init(red: 217/255, green: 180/255, blue: 74/255, alpha: 1)
        //self.view. = UIColor.init(red: 241/255, green: 241/255, blue: 242/255, alpha: 1)
        self.tabBar.barTintColor = UIColor.init(red: 25/255, green: 149/255, blue: 173/255, alpha: 1)
        self.tabBar.layer.borderWidth = 0.50
        self.tabBar.layer.borderColor = UIColor.init(red: 217/255, green: 180/255, blue: 74/255, alpha: 1).cgColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

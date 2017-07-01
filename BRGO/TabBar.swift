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
        self.view.tintColor = Colors.tertiary
        //self.view. = Colors.primary
        self.tabBar.barTintColor = Colors.secondary
        self.tabBar.layer.borderWidth = 0.50
        self.tabBar.layer.borderColor = Colors.tertiary.cgColor

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

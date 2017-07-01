//
//  NavController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/14/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

    //Set the formatting for the navigation bar
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = Colors.primary
        self.navigationBar.backgroundColor = Colors.primary
        let border = CALayer()
        border.backgroundColor = Colors.tertiary.cgColor
        border.frame = CGRect(x:0, y: self.navigationBar.frame.size.height-1, width:  self.navigationBar.frame.size.width, height:  1)
        self.navigationBar.layer.addSublayer(border)
        self.navigationBar.layer.masksToBounds = true
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Bodoni 72", size: 30)!, NSForegroundColorAttributeName: Colors.secondary]
        self
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

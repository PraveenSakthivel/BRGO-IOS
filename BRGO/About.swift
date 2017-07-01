//
//  About.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/31/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class About: UIViewController {

    @IBOutlet var Desc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Desc.backgroundColor = Colors.primary
        Desc.textColor = Colors.secondary
        Desc.font = UIFont(name:"Bodoni 72", size: 16)

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

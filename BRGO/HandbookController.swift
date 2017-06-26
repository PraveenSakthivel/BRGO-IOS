//
//  PlannerController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/21/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class HandbookController: UIViewController, UIWebViewDelegate {
    @IBOutlet var browser: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        browser.delegate = self
        browser.isOpaque = false
        browser.backgroundColor = UIColor.clear
        browser.scalesPageToFit = true
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        var pdfLoc: URL!
        
        let defaults = UserDefaults.standard
        switch defaults.object(forKey: "School") as! Int
        {
        case 14273:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14273Planner", ofType:"pdf")!)
        case 14274:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14274Planner", ofType:"pdf")!)
        case 14271:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14271Planner", ofType:"pdf")!)
        case 14269:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14269Planner", ofType:"pdf")!)
        case 14268:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14264Planner", ofType:"pdf")!)
        case 14264:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14276Planner", ofType:"pdf")!)
        case 14276:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14268Planner", ofType:"pdf")!)
        default:
            pdfLoc = URL(fileURLWithPath:Bundle.main.path(forResource: "14273Planner", ofType:"pdf")!)
        }
        let request = URLRequest(url: pdfLoc);
        browser.loadRequest(request);
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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

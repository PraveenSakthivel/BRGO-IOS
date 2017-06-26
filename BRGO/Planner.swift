//
//  Planner.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/25/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class Planner: UIViewController, CGCalendarViewDelegate{
    var calendarView: CGCalendarView!
    let dateformat: NSDateFormatter! = nil
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarSetUp()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func calendarSetUp() {
        calendarView = (CGCalendarView)(frame: CGRectMake(0,20,320,50))
        calendarView.calendar = calendar
        calendarView.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 242/255, alpha: 1)
        calendarView.rowCellClass = CGCalendarCell.classForCoder()
        calendarView.firstDate = NSDate.init(timeInterval: -60 * 60 * 24 * 30, sinceDate: NSDate())
        calendarView.lastDate = NSDate.init(timeInterval: -60 * 60 * 24 * 30, sinceDate: NSDate())
        calendarView.delegate = self
        self.view.addSubview(calendarView)
        calendarView.selectedDate = NSDate()
        
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


//
//  PlannerController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/25/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit
import CVCalendar
import EventKit

class PlannerController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{
    
    @IBOutlet var menuView: CVCalendarMenuView!
    @IBOutlet var tables: UITableView!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var calendarView: CVCalendarView!
    var shouldShowDaysOut = true
    var animationFinished = true
    var selectedDay:DayView!
    var rows = Int()
    var info = [String]()
    var dataCells = [UITextView]()
    var saveDate: CVDate!
    let dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        saveDate = CVDate(date: Foundation.Date())
        tables.isUserInteractionEnabled = true
        menuView.menuViewDelegate = self
        calendarView.calendarDelegate = self
        getRows()
        let AddButton = UIButton(type: .custom)
        AddButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        AddButton.setTitle("+", for: UIControlState())
        AddButton.setTitleColor(UIColor.init(red: 25/255, green: 149/255, blue: 173/255, alpha: 1), for: UIControlState())
        AddButton.titleLabel!.font = UIFont(name: "Bodoni 72", size: 40)
        let AddView = UIBarButtonItem(customView: AddButton)
        self.navigationItem.rightBarButtonItem = AddView
                AddButton.addTarget(self, action: #selector(self.addRow), for: UIControlEvents.touchUpInside)
        let view = UIView()
        tables.tableFooterView = view
        monthLabel.text = CVDate(date: Foundation.Date()).globalDescription
        monthLabel.textAlignment = NSTextAlignment.center
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let rightSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(self.swipeDateR))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        let leftSwipe = UISwipeGestureRecognizer.init(target: self, action: #selector(self.swipeDateL))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        tables.separatorColor = UIColor.blue
        tables.gestureRecognizers = [rightSwipe, leftSwipe]
        updateInfo()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
    //Adds a left swipe gesture to the Planner
    func swipeDateL(){
        calendarView.toggleViewWithDate(NSDate.init(timeInterval: 86400, since: (saveDate.convertedDate())!) as Date)
        tables.reloadData()
    }
    
    //Adds a right swipe gesture to the Planner
    func swipeDateR(){
        calendarView.toggleViewWithDate(NSDate.init(timeInterval: -86400, since: (saveDate.convertedDate())!) as Date)
        tables.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //Gets the number of data sets for the selected Day
    func getRows(){
        if selectedDay != nil{
            if let data = PlistManager.sharedInstance.getValueForKey(selectedDay.date.commonDescription){
                rows = (data as! [String]).count
                if rows == 0{
                    rows = 1
                }
            }
            else{
                rows = 1
            }
        }
        else if let data = PlistManager.sharedInstance.getValueForKey(CVDate(date: Foundation.Date()).commonDescription)
        {
            rows = (data as! [String]).count
            if rows == 0{
                rows = 1
            }
        }
        else{
            rows = 1
        }
    }
    
    //updates the data set for the selected day
    func updateInfo(){
        info = [String]()
        if selectedDay != nil
        {
        if let data = PlistManager.sharedInstance.getValueForKey(selectedDay.date.commonDescription){
            info = (data as! [String])
        }
        }
        else if let data = PlistManager.sharedInstance.getValueForKey(CVDate(date: Foundation.Date()).commonDescription)
        {
            info = (data as! [String])
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {

    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        info.insert(textView.text, at: textView.tag)
        saveData()
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let alarm = UITableViewRowAction(style: .normal, title: "Add Reminder") { action, index in
            self.addAlarm(position: index)
        }
        alarm.backgroundColor = UIColor.orange
        return [alarm]
    }
    
    //adds an Calendar Event based off the selected Index Path
    func addAlarm(position: IndexPath)
    {
        let store = EKEventStore()
        store.requestAccess(to: .event) {(granted, error) in
            if !granted { return }
            var event = EKEvent(eventStore: store)
            event.title = self.getTitle(position: position)
            if let _ = self.selectedDay
            {
            event.startDate = self.selectedDay.date.convertedDate()! //today
            }
            else{
            event.startDate = NSDate() as Date
            }
            event.endDate = event.startDate.addingTimeInterval(86400) //1 hour long meeting
            event.calendar = store.defaultCalendarForNewEvents
            do {
                try store.save(event, span: .thisEvent, commit: true)
                let alert = UIAlertController(title: "Calendar Event Created", message: "", preferredStyle:  UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            catch {
                // Display error to user
            }
        }
    }
    
    //Returns the title of the selected row
    func getTitle(position: IndexPath) -> String{
        return dataCells[position.row].text!
    }

    //adds an empty textView to the table
    func addRow() {
        rows += 1
        tables.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        let textbox = UITextView(frame: CGRect(x: 0, y: 0,width: (tables.window?.frame.width)! ,height: 199))
        textbox.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 242/255, alpha: 1)
        textbox.isEditable = true
        textbox.isUserInteractionEnabled = true
        if let date = selectedDay
        {
        if let text = PlistManager.sharedInstance.getValueForKey(date.date.commonDescription)
        {
            if (text as! [String]).count > (indexPath as NSIndexPath).row
            {
            textbox.text = (text as! [String])[(indexPath as NSIndexPath).row]
            textbox.tag = (indexPath as NSIndexPath).row
            }
        }
        }
        else{
            if let text = PlistManager.sharedInstance.getValueForKey(CVDate(date: Foundation.Date()).commonDescription)
            {
                if (text as! [String]).count > (indexPath as NSIndexPath).row
                {
                textbox.text = (text as! [String])[(indexPath as NSIndexPath).row]
                textbox.tag = (indexPath as NSIndexPath).row
                }
            }

            
        }
        textbox.delegate = self
        if dataCells.count > indexPath.row
        {
        dataCells.remove(at: indexPath.row)
        }
        dataCells.insert(textbox, at: indexPath.row)
        cell.addSubview(textbox)
        textbox.font = UIFont(name:"Bodoni 72", size: 16)
        textbox.textColor = UIColor.init(red: 25/255, green: 149/255, blue: 173/255, alpha:1)
        cell.isUserInteractionEnabled = true
        cell.textLabel!.text = nil
        cell.bringSubview(toFront: textbox)
        return cell    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tables.deselectRow(at: indexPath, animated:true)
    }
    
    //saves UserData written in the planner
    func saveData(){
         if PlistManager.sharedInstance.getValueForKey(saveDate.commonDescription) != nil
         {
            PlistManager.sharedInstance.saveValue(info as NSArray, forKey: saveDate.commonDescription)
        }
         else{
            PlistManager.sharedInstance.addNewItemWithKey(saveDate.commonDescription, value: info as AnyObject)
            }
        if selectedDay != nil
        {
        saveDate = selectedDay.date
        }
            }
    func dismissKeyboard() {
        print("ok")
        self.view.endEditing(true)
    }

}
    extension PlannerController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
        
        /// Required method to implement!
        func presentationMode() -> CalendarMode {
            return .weekView
        }
        
        /// Required method to implement!
        func firstWeekday() -> Weekday {
            return .sunday
        }
        
        // MARK: Optional methods
        
        func shouldShowWeekdaysOut() -> Bool {
            return shouldShowDaysOut
        }
        
        func shouldAnimateResizing() -> Bool {
            return true // Default value is true
        }
        
        func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
            selectedDay = dayView
            getRows()
            tables.reloadData()
            updateInfo()
            saveDate = selectedDay.date
            
        }
        
        func presentedDateUpdated(_ date: CVDate) {
            if monthLabel.text != date.globalDescription && self.animationFinished {
                let updatedMonthLabel = UILabel()
                updatedMonthLabel.textColor = monthLabel.textColor
                updatedMonthLabel.font = monthLabel.font
                updatedMonthLabel.textAlignment = .center
                updatedMonthLabel.text = date.globalDescription
                updatedMonthLabel.sizeToFit()
                updatedMonthLabel.alpha = 0
                updatedMonthLabel.center = self.monthLabel.center
                
                let offset = CGFloat(48)
                updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
                updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                
                UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.animationFinished = false
                    self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
                    self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                    self.monthLabel.alpha = 0
                    
                    updatedMonthLabel.alpha = 1
                    updatedMonthLabel.transform = CGAffineTransform.identity
                    
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransform.identity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
                }
                
                self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
            }
        }
        
        func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
            return true
        }
        
        func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
            let day = dayView.date.day
            let randomDay = Int(arc4random_uniform(31))
            if day == randomDay {
                return true
            }
            
            return false
        }
        
        func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
            
            let red = CGFloat(arc4random_uniform(600) / 255)
            let green = CGFloat(arc4random_uniform(600) / 255)
            let blue = CGFloat(arc4random_uniform(600) / 255)
            
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
            
            let numberOfDots = Int(arc4random_uniform(3) + 1)
            switch(numberOfDots) {
            case 2:
                return [color, color]
            case 3:
                return [color, color, color]
            default:
                return [color] // return 1 dot
            }
        }
        
        func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
            return true
        }
        
        func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
            return 13
        }
        
        
        func weekdaySymbolType() -> WeekdaySymbolType {
            return .short
        }
        
        func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
            return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
        }
        
        func shouldShowCustomSingleSelection() -> Bool {
            return false
        }
        
        func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
            let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.circle)
            circleView.fillColor = .colorFromCode(0xCCCCCC)
            return circleView
        }
        
        func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
            if (dayView.isCurrentDay) {
                return true
            }
            return false
        }
        
        func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
            let π = M_PI
            
            let ringSpacing: CGFloat = 3.0
            let ringInsetWidth: CGFloat = 1.0
            let ringVerticalOffset: CGFloat = 1.0
            var ringLayer: CAShapeLayer!
            let ringLineWidth: CGFloat = 4.0
            let ringLineColour: UIColor = UIColor.white
            
            let newView = UIView(frame: dayView.bounds)
            
            let diameter: CGFloat = (newView.bounds.width) - ringSpacing
            let radius: CGFloat = diameter / 2.0
            
            let rect = CGRect(x: newView.frame.midX-radius, y: newView.frame.midY-radius-ringVerticalOffset, width: diameter, height: diameter)
            
            ringLayer = CAShapeLayer()
            newView.layer.addSublayer(ringLayer)
            
            ringLayer.fillColor = nil
            ringLayer.lineWidth = ringLineWidth
            ringLayer.strokeColor = ringLineColour.cgColor
            
            let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
            let ringRect: CGRect = rect.insetBy(dx: ringLineWidthInset, dy: ringLineWidthInset)
            let centrePoint: CGPoint = CGPoint(x: ringRect.midX, y: ringRect.midY)
            let startAngle: CGFloat = CGFloat(-π/2.0)
            let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
            let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            ringLayer.path = ringPath.cgPath
            ringLayer.frame = newView.layer.bounds
            
            return newView
        }
        
        func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
            if (Int(arc4random_uniform(3)) == 1) {
                return true
            }
            
            return false
        }
        
        func dayOfWeekTextColor() -> UIColor {
            return UIColor.black
        }
        
        func dayOfWeekBackGroundColor() -> UIColor {
            return UIColor.orange
        }
    }
    extension PlannerController: CVCalendarViewAppearanceDelegate {
        func dayLabelPresentWeekdayInitallyBold() -> Bool {
            return false
        }
        
        func spaceBetweenDayViews() -> CGFloat {
            return 2
        }
    }
extension PlannerController {
    func toggleMonthViewWithMonthOffset(_ offset: Int) {
        let calendar = Calendar.current
        //        let calendarManager = calendarView.manager
        var components = Manager.componentsForDate(Foundation.Date()) // from today
        
        components.month! += offset
        
        let resultDate = calendar.date(from: components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowNextMonthView(_ date: Foundation.Date)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month)")
    }
    
    
    func didShowPreviousMonthView(_ date: Foundation.Date)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month)")
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



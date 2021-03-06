//
//  CalendarController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/6/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class CalendarController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
    var parser: XMLParser = XMLParser()
    var info: [newsarticle] = []
    var postTitle: String = String()
    var postDesc: String = String()
    var eName: String = String()
    var index: Int = Int()
    var organizedinfo: [String] = [String]()
    var headDates: String = String()
    var mapper: [Int]  = [Int]()
    var datemapper: [Int] = [Int]()
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    @IBOutlet var multiview: UITableView!
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let url:URL = URL(string: "http://" + schoolPrefix() + "brrsd.org/apps/events2/events_rss.jsp?id=0")! //Insert the url for the RSS Feed
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        orgData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(CalendarController.refresh(_:)), for: UIControlEvents.valueChanged)
        
        multiview.addSubview(refreshControl)
        multiview.separatorColor = Colors.tertiary
        let background = UIView()
        background.tintColor = Colors.primary
        multiview.tableFooterView = background
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    //Organize the Calendar events by date
    func orgData(){
        var i = 0
        while i < info.count{
            if((info[i].description) == headDates)
            {
                mapper.append(organizedinfo.count)
                organizedinfo.append("*" + info[i].title)
            }
            else{
                datemapper.append(organizedinfo.count)
                organizedinfo.append("[" + info[i].description + "]")
                mapper.append(organizedinfo.count)
                organizedinfo.append("*" + info[i].title)
                headDates = info[i].description
            }
            i += 1
        }
    }
    func refresh(_ sender: AnyObject)
    {
        let url:URL = URL(string: "http://" + schoolPrefix() + "brrsd.org/apps/events2/events_rss.jsp?id=0")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        multiview.reloadData()
        refreshControl.endRefreshing()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes attributeDict: [String : String])
    {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postDesc = String()
        }
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
        return organizedinfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var format = false
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        if let label = cell.textLabel {
            label.text = organizedinfo[(indexPath as NSIndexPath).row]
        }
        for element in datemapper{
            if element == (indexPath as NSIndexPath).row{
                format = true
            }
        }
        if format
        {
            cell.backgroundColor = Colors.secondary
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 16)
        }
        else{
            cell.backgroundColor = Colors.primary
            cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 16)
            cell.textLabel!.textColor = Colors.secondary
        }
        return cell    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "title" { //eName is the XML identifier
                postTitle += data
            } else if eName == "description" {
                postDesc += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let newsart: newsarticle = newsarticle()
            newsart.title = postTitle
            newsart.description = postDesc
            info.append(newsart)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = (indexPath as NSIndexPath).row
        var a = true
        for element in datemapper{
            if element == index
            {
                a = false
            }
        }
        multiview.deselectRow(at: indexPath, animated:true)
        if a{
            performSegue(withIdentifier: "CalendarTransfer", sender:self)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Destination: FullCalendar = segue.destination as! FullCalendar
        var i = 0
        while mapper[i] != index{
            i += 1
        }
        Destination.info = info[i]
        
        
    }
    //Converts the OnCourse school code into the corresponding subdomain
    func schoolPrefix() -> String{
        let defaults = UserDefaults.standard
        let url: String
        switch (defaults.object(forKey: "School") as! Int){
        case 14273:
            url = "hs."
            break;
        case 14276:
            url = "ms."
            break;
        case 14274:
            url = "hi."
            break;
        case 14271:
            url = "ei."
            break;
        case 14278:
            url = "vh."
            break;
        case 14277:
            url = "mi."
            break;
        case 14275:
            url = "jfk."
            break;
        case 14272:
            url = "ha."
            break;
        case 14269:
            url = "cr."
            break;
        case 14268:
            url = "bg."
            break;
        case 14264:
            url = "ad."
            break;
        default:
            url = "hs."
            break;
        }
        return url
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

//
//  NewController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/6/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class NewController: UIViewController, UITableViewDataSource, UITableViewDelegate, XMLParserDelegate {
    @IBOutlet weak var tables: UITableView!

    var parser: XMLParser = XMLParser()
    var info: [newsarticle] = []
    var postTitle: String = String()
    var postDesc: String = String()
    var eName: String = String()
    var index: Int = Int()
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    var refreshControl: UIRefreshControl!
   override func viewDidLoad() {
    let navicon = UIButton(type: UIButtonType.system)
    navicon.setImage(defaultMenuImage(), for: UIControlState())
    navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    let menu = UIBarButtonItem(customView: navicon)
    self.navigationItem.leftBarButtonItem = menu
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let url:URL = URL(string: "http://" + schoolPrefix() + "brrsd.org/apps/news/news_rss.jsp?id=0")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
    print(parser.parserError)
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(NewController.refresh(_:)), for: UIControlEvents.valueChanged)
    tables.separatorColor = UIColor.init(red: 217/255, green: 180/255, blue: 74/255, alpha: 1)
    tables.addSubview(refreshControl)
    tables.tableFooterView = UIView(frame: CGRect.zero)
 //   self.view.window!.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 242/255, alpha: 1.0)
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    func refresh(_ sender: AnyObject)
    {
        info = [newsarticle]()
        let url:URL = URL(string: "http://" + schoolPrefix() + "brrsd.org/apps/news/news_rss.jsp?id=0")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        tables.reloadData()
        refreshControl.endRefreshing()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes attributeDict: [String : String])
    {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postDesc = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "title" {
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
        if info.count > 0
        {
        return info.count
        }
        else{
            info.append(newsarticle(name: "No News",desc: "No News"))
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        let news: newsarticle = info[(indexPath as NSIndexPath).row]
        if let label = cell.textLabel {
            label.text = news.title
        }
        cell.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 242/255, alpha: 1)
        cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 16)
        cell.textLabel!.textColor = UIColor.init(red: 25/255, green: 149/255, blue: 173/255, alpha: 1)
        return cell    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = (indexPath as NSIndexPath).row
        tables.deselectRow(at: indexPath, animated:true)
            performSegue(withIdentifier: "NewsTransfer", sender:self)
    }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Destination: FullNews = segue.destination as! FullNews
        Destination.info = info[index]

    }
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

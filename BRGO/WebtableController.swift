//
//  WebtableController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/18/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit
import Alamofire


class WebtableController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    var names =  [String]()
    var school: String = String()
    var data: [newsarticle] = [newsarticle]()
    var index: Int = Int()
    var searchResults: [String] = [String]()
    var searchController =  UISearchController(searchResultsController: nil)
    var searchIndex: [Int] = [Int]()
    var refreshController: UIRefreshControl!
    let dataToggle = UISwitch()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(WebtableController.refresh(_:)), for: UIControlEvents.valueChanged)
        self.tableView.separatorColor = UIColor.init(red: 217/255, green: 180/255, blue: 74/255, alpha: 1)
        self.tableView.addSubview(refreshController)
        getdata()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        let toggleView = UIBarButtonItem(customView: dataToggle)
        self.navigationItem.rightBarButtonItem = toggleView
        dataToggle.addTarget(self, action: #selector(self.PreferencesToggled(_:)), for: UIControlEvents.touchUpInside)
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let defaults = UserDefaults.init(suiteName: "group.BRGO.data")
        //This Section will have to be removed next update
        if(!(defaults?.bool(forKey: "hasConverted"))!)
        {
            prefToData()
            defaults?.set(true, forKey: "hasConverted")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func PreferencesToggled(_ sender: UIButton) {
        let defaults = UserDefaults.init(suiteName: "group.BRGO.data")
        if dataToggle.isOn
        {
            if (defaults?.bool(forKey: "isData"))!{
                data = savedData()
                self.tableView.reloadData()
            }
            else{
                data = [newsarticle]()
                data.append(newsarticle(name: "No Teachers Saved",desc: "http://www.google.com"))
                let alert = UIAlertController(title: "No Teachers Saved", message: "", preferredStyle:  UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.tableView.reloadData()
            }
            let footer = UIView()
            self.tableView.tableFooterView = footer
        }
        else{
            self.tableView.tableFooterView = nil
            getdata()
        }
    }
    
    func refresh(_ sender: AnyObject)
    {
        dataToggle.setOn(false, animated: true)
        getdata()
        refreshController.endRefreshing()
    }
    func toStringArray() -> [String]
    {
        var temp = [String]()
        for element in data
        {
            temp.append(element.title)
        }
        return temp
    }
    func toStringArray(_info:[newsarticle]) -> [String]{
        var temp = [String]()
        for element in _info
        {
            temp.append(element.title)
        }
        return temp
    }
    func updateSearchResults(for searchController: UISearchController) {
        searchResults.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (toStringArray() as NSArray).filtered(using: searchPredicate)
        searchResults = array as! [String]
        if searchResults.count == 0
        {
            searchResults = toStringArray()
        }
        
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func getdata(){
        let defaults = UserDefaults.standard
        let school = defaults.object(forKey: "School") as! Int
        let myJsonDict = [
            
            "action":"Websites",
            "method":"school_webpage",
            "tid":2,
            "data":[["schoolId":school]],
            "type":"rpc"
            ] as [String : Any]
        
        var mutableURLRequest = URLRequest(url: URL(string: "https://wwww.oncoursesystems.com/json.axd/direct/router")!)
        
        mutableURLRequest.httpMethod = "POST"
        
        let options = JSONSerialization.WritingOptions()
        
        
        mutableURLRequest.httpBody = try! JSONSerialization.data(withJSONObject: myJsonDict, options: options)
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(mutableURLRequest)
            .validate()
            .responseJSON { response in
                self.parseJson(response.result.value as! NSDictionary)
        }
    }
    func parseJson(_ JsonDict: AnyObject)
    {
        var data = [newsarticle]()
        let Dictionary = JsonDict as? [String: AnyObject]
        if let Results = Dictionary?["result"]?["ReturnValue"]{
            if let Tree = (Results as! [String: AnyObject])["tree"]  as? [AnyObject] {
                for List  in Tree {
                    if let Children = List["children"]  as? [AnyObject]{
                        for item in Children{
                            let datum = item as? [String: AnyObject]
                            data.append(newsarticle(name: (datum?["text"])! as! String,desc: "https://www.oncoursesystems.com/school/webpage/\(datum?["id"] as! NSNumber)/689493"))
                        }
                        
                    }
                }
                addData(data)
            }
        }
    }
    func addData(_ info: [newsarticle])
    {
        data = info
        for element in info
        {
            names.append(element.title)
        }
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(searchController.isActive)
        {
            return searchResults.count
        }
        else
        {
            return data.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if(searchController.isActive)
        {
            cell.textLabel?.text = searchResults[(indexPath as NSIndexPath).row]
        }
        else{
            cell.textLabel?.text = data[(indexPath as NSIndexPath).row].title
        }
        cell.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 242/255, alpha: 1)
        cell.textLabel!.font = UIFont(name:"Bodoni 72", size: 16)
        cell.textLabel!.textColor = UIColor.init(red: 25/255, green: 149/255, blue: 173/255, alpha: 1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if !dataToggle.isOn
        {
            let save = UITableViewRowAction(style: .normal, title: "Save") { action, index in
                let defaults = UserDefaults.init(suiteName: "group.BRGO.data")!
                if (defaults.bool(forKey:"isData")){
                    var sNames = defaults.stringArray(forKey: "TeachNames")!
                    var sLinks = defaults.stringArray(forKey:"TeachLinks")!
                    if self.searchController.isActive{
                        var i = 0
                        while i < self.names.count {
                            if self.searchResults[(indexPath as NSIndexPath).row] == self.names[i]
                            {
                                self.index = i
                                i = self.names.count
                            }
                            i += 1
                        }
                        sNames.append(self.data[self.index].title)
                        sLinks.append(self.data[self.index].title)
                    }
                    else{
                        sNames.append(self.data[(indexPath as NSIndexPath).row].title)
                        sLinks.append(self.data[(indexPath as NSIndexPath).row].description)
                    }
                    defaults.set(sNames, forKey: "TeachNames")
                    defaults.set(sLinks, forKey: "TeachLinks")
                }
                else{
                    var sNames = [String]()
                    var sLinks = [String]()
                    if self.searchController.isActive{
                        var i = 0
                        while i < self.names.count {
                            if self.searchResults[self.index] == self.names[i]
                            {
                                self.index = i
                                i = self.names.count
                            }
                            i += 1
                        }
                        sNames.append(self.data[self.index].title)
                        sLinks.append(self.data[self.index].title)
                    }
                    else{
                        sNames.append(self.data[(indexPath as NSIndexPath).row].title)
                        sLinks.append(self.data[(indexPath as NSIndexPath).row].description)
                    }
                    defaults.set(sNames, forKey: "TeachNames")
                    defaults.set(sLinks, forKey: "TeachLinks")
                }
                let alert = UIAlertController(title: "Teacher Saved", message: "", preferredStyle:  UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.updateStatus()
            }
            save.backgroundColor = UIColor.init(red: 25/255, green: 149/255, blue: 173/255, alpha: 1)
            return [save]
        }
        else{
            let remove = UITableViewRowAction(style: .normal, title: "Remove") { action, index in
                let defaults = UserDefaults.init(suiteName: "group.BRGO.data")!
                var sNames = defaults.stringArray(forKey: "TeachNames")!
                var sLinks = defaults.stringArray(forKey:"TeachLinks")!
                sNames.remove(at: (indexPath as NSIndexPath).row)
                sLinks.remove(at: (indexPath as NSIndexPath).row)
                defaults.set(sNames, forKey: "TeachNames")
                defaults.set(sLinks, forKey: "TeachLinks")
                self.data = self.savedData()
                if(self.data.count == 0)
                {
                    let alert = UIAlertController(title: "No Teachers Saved", message: "", preferredStyle:  UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                self.tableView.reloadData()
                self.updateStatus()
            }
            remove.backgroundColor = UIColor.red
            return [remove]
        }
    }
    
    func prefToData()
    {
        let links = PlistManager.sharedInstance.getValueForKey("TeachLinks") as! [String]
        let tnames = PlistManager.sharedInstance.getValueForKey("TeachNames") as! [String]
        let defaults = UserDefaults.init(suiteName: "group.BRGO.data")!
        defaults.set(tnames, forKey: "TeachNames")
        defaults.set(links, forKey: "TeachLinks")
        updateStatus()
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = (indexPath as NSIndexPath).row
        self.tableView.deselectRow(at: indexPath, animated:true)
        performSegue(withIdentifier: "WebTransfer", sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if searchController.isActive{
            var i = 0
            while i < names.count {
                if searchResults[index] == names[i]
                {
                    index = i
                    i = names.count
                }
                i += 1
            }
        }
        let Destination: WebsiteController = segue.destination as! WebsiteController
        Destination.postLink = data[index].description
    }
    func updateStatus(){
        print("saved")
        let defaults = UserDefaults.init(suiteName: "group.BRGO.data")!
        if((defaults.stringArray(forKey: "TeachNames")!).count == 0){
            
            defaults.set(false, forKey: "isData")
        }
        else{
            defaults.set(true, forKey: "isData")
        }
    }
    func savedData() -> [newsarticle]{
        let defaults = UserDefaults.init(suiteName: "group.BRGO.data")
        let sNames = defaults?.stringArray(forKey: "TeachNames")
        let sLinks = defaults?.stringArray(forKey: "TeachLinks")
        var temp = [newsarticle]()
        var i = 0;
        while i < (sNames?.count)!
        {
            temp.append(newsarticle(name: (sNames?[i])!,desc: (sLinks?[i])!))
            i += 1
        }
        return temp
    }
    
}

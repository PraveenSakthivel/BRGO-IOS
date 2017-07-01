//
//  WebsiteController.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/8/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

//The browser view for WebTableController
class WebsiteController: UIViewController, UIWebViewDelegate {
    var postLink: String = String()

    @IBOutlet var LoadingIcon: UIActivityIndicatorView!
    @IBOutlet weak var Browser: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url: URL = URL(string: postLink.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
        let request: URLRequest = URLRequest(url: url.deletingLastPathComponent())
        Browser.loadRequest(request)
        Browser.delegate = self
        Browser.isOpaque = false
        Browser.backgroundColor = UIColor.clear
        Browser.scalesPageToFit = true
        let backText = UIButton(type: .custom)
        backText.frame = CGRect(x: 0, y: 0, width: 40, height: 80)
        backText.setTitle("<", for: UIControlState())
        backText.setTitleColor(Colors.secondary, for: UIControlState())
        backText.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        let forText = UIButton(type: .custom)
        forText.frame = CGRect(x: 0, y: 0, width: 40, height: 80)
        forText.setTitle(">", for: UIControlState())
        forText.setTitleColor(Colors.secondary, for: UIControlState())
        forText.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        let back = UIBarButtonItem(customView: backText)
        let forward = UIBarButtonItem(customView: forText)
        self.navigationItem.rightBarButtonItems = [forward,back]
        backText.addTarget(self, action: #selector(self.goB), for: UIControlEvents.touchUpInside)
        forText.addTarget(self, action: #selector(self.goF), for: UIControlEvents.touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    func goF(){
        Browser.goForward()
    }
    func goB(){
        Browser.goBack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        LoadingIcon.transform = CGAffineTransform(scaleX: 2, y: 2);
        LoadingIcon.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        LoadingIcon.stopAnimating()
        LoadingIcon.isHidden = true
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

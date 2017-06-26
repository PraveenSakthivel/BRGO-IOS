//
//  AppDelegate.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 6/12/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
        self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "MainController")
        }
        else {
          self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "Welcome_Screen") as UIViewController
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        view.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 242/255, alpha: 1)
        self.window?.rootViewController?.view.addSubview(view)
        self.window?.makeKeyAndVisible()
        PlistManager.sharedInstance.startPlistManager()
        window?.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 242/255, alpha: 1)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var view =  storyboard.instantiateViewController(withIdentifier: "Website") as! WebsiteController
            let defaults = UserDefaults.init(suiteName: "group.BRGO.data")
            let linknum = (defaults?.stringArray(forKey: "TeachLinks"))![Int(url.absoluteString.components(separatedBy: "T")[1])!]
            view.postLink = linknum
            print(linknum)
            self.window?.rootViewController = view
        
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


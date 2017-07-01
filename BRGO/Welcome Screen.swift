//
//  Welcome Screen.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/17/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit

class Welcome_Screen: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var Button: UIButton!
    @IBOutlet var PickerView: UIPickerView!
    var index = Int()
    //insert the names of your district schools here
    let pickerDataSource = ["High School", "Middle School", "Hillside", "Eisenhower", "Van Holten","Milltown", "John F. Kennedy","Hamilton", "Crim","Bradely Gardens", "Adamsville"];
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerView.dataSource = self;
        PickerView.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**These are OnCourse systems code for your school. If your school doesnt use this
     service, use your own identifying numbers*/
    @IBAction func ButtonPress(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        switch index {
        case 0:
            defaults.set(14273, forKey: "School")
        case 1:
            defaults.set(14276, forKey: "School")
        case 2:
            defaults.set(14274, forKey: "School")
        case 3:
            defaults.set(14271, forKey: "School")
        case 4:
            defaults.set(14278, forKey: "School")
        case 5:
            defaults.set(14277, forKey: "School")
        case 6:
            defaults.set(14275, forKey: "School")
        case 7:
            defaults.set(14272, forKey: "School")
        case 8:
            defaults.set(14269, forKey: "School")
        case 9:
            defaults.set(14268, forKey: "School")
        case 10:
            defaults.set(14264, forKey: "School")
        default:
            defaults.set(14273, forKey: "School")
        }
            performSegue(withIdentifier: "Initial", sender:self)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        index = row
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

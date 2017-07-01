//
//  StudentID.swift
//  BRGO
//
//  Created by Praveen Sakthivel on 7/26/16.
//  Copyright © 2016 TBLE Technologies. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
class StudentID: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var cameraUI: UIImagePickerController! = UIImagePickerController()
    @IBOutlet var firstPick: UIButton!
    
    @IBOutlet var Img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults()
        Img.isHidden = true
        if defaults.bool(forKey: "ID")
        {
            Img.isHidden = false
            Img.image = UIImage((contentsOfFile: fileinDocumentsDirectory("ID")))
            Img.layer.setAffineTransform(CGAffineTransform(rotationAngle: 1.57))
        }
        // Do any additional setup after loading the view.
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let retake = UIButton(type: .custom)
        retake.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        var bundlePath = Bundle.main.path(forResource: "photoIcon", ofType: "png")
        retake.setBackgroundImage(UIImage(contentsOfFile: bundlePath!), for: UIControlState())
        let retakeView = UIBarButtonItem(customView: retake)
        self.navigationItem.rightBarButtonItem = retakeView
        retake.addTarget(self, action: #selector(self.takePicture), for: .touchUpInside)
        firstPick.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
        bundlePath = Bundle.main.path(forResource: "OriginalPhoto", ofType: "png")
        firstPick.setBackgroundImage(UIImage(contentsOfFile: bundlePath!), for: UIControlState())
       // Img.contentMode = UIViewContentMode.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func takePicture(_ sender: AnyObject) {
        presentCamera()
    }
    
    //Starts the picture taking proccess
    func presentCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            cameraUI = UIImagePickerController()
            cameraUI.delegate = self
            cameraUI.sourceType = UIImagePickerControllerSourceType.camera
            cameraUI.mediaTypes = [kUTTypeImage as String]
            cameraUI.allowsEditing = false
            self.present(cameraUI, animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]) {
        if (picker.sourceType == UIImagePickerControllerSourceType.camera)
        {
            let imageToSave: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            saveImage(imageToSave, path: fileinDocumentsDirectory("ID"))
        }
    }
    //Gets the url for the where the picture is/will be saved
    func getDocumentsURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    func fileinDocumentsDirectory(_ filename: String) -> String {
    let fileURL = getDocumentsURL().appendingPathComponent(filename)
    return fileURL.path
    }
    
    //save the image to a specific path
    func saveImage(_ image: UIImage, path: String) -> Bool{
        let pngImageData = UIImagePNGRepresentation(image)
        let result = (try? pngImageData!.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil
        let defaults = UserDefaults()
        defaults.set(result, forKey: "ID")
        self.dismiss(animated: true, completion: nil)
        self.viewDidLoad()
        return result
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

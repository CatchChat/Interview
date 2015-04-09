//
//  ViewController.swift
//  Interview
//
//  Created by kevinzhow on 15/4/3.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

let highLightColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
let defaultLightColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)

enum InterviewState {
    case Default
    case Name
    case Subtitle
    case Save
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var inImageView: InImageView!
    
    var imagePicker = UIImagePickerController()
    
    var textView: UITextField!
    
    var doneButton: UIButton!
    
    var changeName: UIButton!
    
    var changeSubtitle: UIButton!
    
    var tempImageView: UIImageView!
    
    @IBOutlet weak var albumImage: UIImageView!
    var savePhoto: UIButton!
    
    @IBOutlet weak var cameraImage: UIImageView!
    var state: InterviewState = .Default {
        willSet {
            switch newValue {
            case .Default:
                self.textView.alpha = 0.0
                self.changeName.alpha = 0.0
                self.changeSubtitle.alpha = 0.0
                self.savePhoto.alpha = 0.0
                changeName.backgroundColor = defaultLightColor
                changeSubtitle.backgroundColor = defaultLightColor
                savePhoto.backgroundColor = defaultLightColor

            case .Name:
                self.textView.alpha = 1.0
                self.changeName.alpha = 1.0
                self.changeSubtitle.alpha = 1.0
                self.savePhoto.alpha = 1.0
                changeName.backgroundColor = highLightColor
                changeSubtitle.backgroundColor = defaultLightColor
                savePhoto.backgroundColor = defaultLightColor
                inImageView.charaterChangeAction!()
                
            case .Subtitle:
                self.textView.alpha = 1.0
                self.changeName.alpha = 1.0
                self.changeSubtitle.alpha = 1.0
                self.savePhoto.alpha = 1.0
                changeName.backgroundColor = defaultLightColor
                changeSubtitle.backgroundColor = highLightColor
                savePhoto.backgroundColor = defaultLightColor
                inImageView.subtitleChangeAction!()
                
            case .Save:
                self.textView.alpha = 1.0
                self.changeName.alpha = 1.0
                self.changeSubtitle.alpha = 1.0
                self.savePhoto.alpha = 1.0
                changeName.backgroundColor = defaultLightColor
                changeSubtitle.backgroundColor = defaultLightColor
                savePhoto.backgroundColor = highLightColor
                textView.resignFirstResponder()
                textView.alpha = 0.0

            }
            
        }
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = defaultLightColor
        
        inImageView = InImageView(frame: CGRectMake(0, 0, self.view.bounds.width, (self.view.bounds.width/16)*9))
        tempImageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, (self.view.bounds.width/16)*9-50))
        tempImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        inImageView.contentMode = UIViewContentMode.ScaleAspectFill
        inImageView.userInteractionEnabled = true
        inImageView.clipsToBounds = true
        self.view.addSubview(inImageView)

        
        var offset:CGFloat = 0
        
        if self.view.bounds.height == 480 {
            inImageView.center = CGPointMake(inImageView.center.x, inImageView.center.y-1000)
            offset = 50
            self.view.addSubview(tempImageView)
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        textView = UITextField(frame: CGRectMake(0, inImageView.frame.size.height + 45.0 - offset, self.view.bounds.width, 50.0))
        textView.userInteractionEnabled = false
        textView.delegate = self
        textView.backgroundColor = highLightColor
        textView.tag = 0
        textView.font = UIFont.systemFontOfSize(20.0)
        textView.textColor = UIColor(white: 1.0, alpha: 0.5)
        textView.alpha = 0.0
        textView.returnKeyType = UIReturnKeyType.Done
        textView.addTarget(self, action: "textViewTextChange", forControlEvents: UIControlEvents.EditingChanged)
        self.view.addSubview(textView)
        
        changeName = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        changeName.frame = CGRectMake(0, inImageView.frame.size.height - offset, self.view.bounds.width/3.0, 45)
        changeName.backgroundColor = defaultLightColor
        changeName.setTitle("Name".localized, forState: UIControlState.Normal)
        changeName.setTitleColor(UIColor(white: 1.0, alpha: 0.5), forState: UIControlState.Normal)
        changeName.addTarget(self, action: "charaterChangeAction", forControlEvents: UIControlEvents.TouchUpInside)
        changeName.alpha = 0.0
        self.view.addSubview(changeName)
        
        changeSubtitle = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        changeSubtitle.frame = CGRectMake(self.view.bounds.width/3.0, inImageView.frame.size.height - offset , self.view.bounds.width/3.0, 45)
        changeSubtitle.backgroundColor = defaultLightColor
        changeSubtitle.setTitle("Subtitle".localized, forState: UIControlState.Normal)
        changeSubtitle.setTitleColor(UIColor(white: 1.0, alpha: 0.5), forState: UIControlState.Normal)
        changeSubtitle.addTarget(self, action: "subtitleChangeAction", forControlEvents: UIControlEvents.TouchUpInside)
        changeSubtitle.alpha = 0.0
        self.view.addSubview(changeSubtitle)
        
        savePhoto = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        savePhoto.frame = CGRectMake(2*self.view.bounds.width/3.0, inImageView.frame.size.height - offset, self.view.bounds.width/3.0, 45)
        savePhoto.backgroundColor = defaultLightColor
        savePhoto.setTitle("Share".localized, forState: UIControlState.Normal)
        savePhoto.setTitleColor(UIColor(white: 1.0, alpha: 0.5), forState: UIControlState.Normal)
        savePhoto.addTarget(self, action: "donePhotoSaveChange", forControlEvents: UIControlEvents.TouchUpInside)
        savePhoto.alpha = 0.0
        self.view.addSubview(savePhoto)
        
        
        inImageView.charaterChangeAction = {
            println("Chage Charater")
            self.textView.userInteractionEnabled = true
            self.textView.text = self.inImageView.charaterLabel.text
            self.textView.tag = 0
            self.textView.becomeFirstResponder()
        }
        
        inImageView.subtitleChangeAction = {
            println("Chage Subtitle")
            self.textView.userInteractionEnabled = true
            self.textView.text = self.inImageView.subtitleLabel.text
            self.textView.tag = 1
            self.textView.becomeFirstResponder()
        }
        
        
        cameraImage.userInteractionEnabled = true
        albumImage.userInteractionEnabled = true
        
        let recognizer = UITapGestureRecognizer(target: self, action:Selector("chooseFromCamera:"))
        let recognizer2 = UITapGestureRecognizer(target: self, action:Selector("chooseFromAlbum:"))
        // 4
        cameraImage.addGestureRecognizer(recognizer)
        
        albumImage.addGestureRecognizer(recognizer2)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textViewTextChange() {
        switch self.textView.tag{
        case 0:
            inImageView.charaterText = self.textView.text
        case 1:
            inImageView.subtitleText = self.textView.text
        default:
            break
        }
        
        self.inImageView.previewImage()
        updateTempImageView()

    }
    
    func updateTempImageView() {
        UIGraphicsBeginImageContextWithOptions(inImageView.bounds.size, false, UIScreen.mainScreen().scale)
        var resizedContext = UIGraphicsGetCurrentContext()
        inImageView.layer.renderInContext(resizedContext)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = image
    }
    
    func charaterChangeAction() {
        self.state = .Name

    }
    
    func subtitleChangeAction() {
        self.state = .Subtitle

    }
    
    func donePhotoSaveChange() {
        
        self.state = .Save
        // do image magic
        UIGraphicsBeginImageContextWithOptions(inImageView.bounds.size, false, UIScreen.mainScreen().scale)
        var resizedContext = UIGraphicsGetCurrentContext()
        inImageView.layer.renderInContext(resizedContext)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // reset Frame of view to origin
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        var sharingItems = [AnyObject]()
        sharingItems.append(image)
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func pickImageFromAlbum(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            println("Button capture")
            
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    func pickImageFromCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            println("Button capture")
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;

            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        inImageView.image = image
        
        inImageView.previewImage()
        updateTempImageView()
        self.state = .Name
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseFromCamera(sender: AnyObject) {
        self.pickImageFromCamera()
    }

    
    @IBAction func chooseFromAlbum(sender: AnyObject) {
        self.pickImageFromAlbum()
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > textField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        {
            return false
        }
        
        var newLength = textField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - range.length
        return (newLength > 65) ? false : true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
}


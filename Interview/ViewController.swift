//
//  ViewController.swift
//  Interview
//
//  Created by kevinzhow on 15/4/3.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var inImageView: InImageView!
    
    var imagePicker = UIImagePickerController()
    
    var textView: UITextField!
    
    var doneButton: UIButton!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        inImageView = InImageView(frame: CGRectMake(0, 50, self.view.bounds.width, (self.view.bounds.width/16)*9))
        inImageView.contentMode = UIViewContentMode.ScaleAspectFill
        inImageView.userInteractionEnabled = true
        inImageView.clipsToBounds = true
        self.view.addSubview(inImageView)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        textView = UITextField(frame: CGRectMake(0, 0, self.view.bounds.width, 50.0))
        textView.userInteractionEnabled = false
        textView.delegate = self
        textView.backgroundColor = UIColor.whiteColor()
        textView.tag = 0
        textView.font = UIFont.systemFontOfSize(25.0)
        self.view.addSubview(textView)
        
        doneButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        doneButton.backgroundColor = UIColor.whiteColor()
        doneButton.frame = CGRectMake(textView.frame.width - 100, 0, 100, 50)
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.hidden = true
        doneButton.addTarget(self, action: "doneTextChange", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(doneButton)
        
        inImageView.charaterChangeAction = {
            println("Chage Charater")
            self.textView.userInteractionEnabled = true
            self.textView.text = self.inImageView.charaterLabel.text
            self.textView.tag = 0
            self.textView.becomeFirstResponder()
            self.doneButton.hidden = false
        }
        
        inImageView.subtitleChangeAction = {
            println("Chage Subtitle")
            self.textView.userInteractionEnabled = true
            self.textView.text = self.inImageView.subtitleLabel.text
            self.textView.tag = 1
            self.textView.becomeFirstResponder()
            self.doneButton.hidden = false
        }
        
        showActionSheet()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func doneTextChange() {
        
        switch self.textView.tag{
        case 0:
            inImageView.charaterText = self.textView.text
        case 1:
            inImageView.subtitleText = self.textView.text
        default:
            break
        }
        
        self.inImageView.previewImage()
    }
    
    func showActionSheet() {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Photo", preferredStyle: .ActionSheet)
        
        // 2
        let albumAction = UIAlertAction(title: "Album", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pickImageFromAlbum()
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.pickImageFromCamera()
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in

        })
        
        
        // 4
        optionMenu.addAction(albumAction)
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
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
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        inImageView.image = image
        
        inImageView.previewImage()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > textField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        {
            return false
        }
        
        var newLength = textField.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - range.length
        return (newLength > 35) ? false : true
    }
    
}


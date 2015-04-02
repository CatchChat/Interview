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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inImageView = InImageView(frame: CGRectMake(0, 50, self.view.bounds.width, (self.view.bounds.width/16)*9))
        inImageView.contentMode = UIViewContentMode.ScaleAspectFill
        inImageView.clipsToBounds = true
        self.view.addSubview(inImageView)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        
        showActionSheet()
        // Do any additional setup after loading the view, typically from a nib.
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
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


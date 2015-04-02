//
//  ViewController.swift
//  Interview
//
//  Created by kevinzhow on 15/4/3.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var inImageView: InImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inImageView = InImageView(frame: CGRectMake(0, 0, self.view.bounds.width, (self.view.bounds.width/16)*9))
        inImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(inImageView)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


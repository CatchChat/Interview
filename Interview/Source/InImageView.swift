//
//  InImageView.swift
//  Interview
//
//  Created by kevinzhow on 15/4/3.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

class InImageView: UIImageView {
    
    var subtitleLabel: UILabel!
    
    var charaterLabel: UILabel!
    
    var charaterView: UIImageView!
    
    var tvStationView: UIImageView!
    
    var showView: UIImageView!
    
    var charaterChangeAction: (() -> ())?

    var subtitleChangeAction: (() -> ())?
    
    var subtitleText = "我当时就吓尿了"
    
    var charaterText = "市民 叶先生"
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.boldSystemFontOfSize(13.0)
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.sizeToFit()
        subtitleLabel.shadowColor = UIColor.blackColor()
        subtitleLabel.shadowOffset = CGSizeMake(1, 1)
        
        var tabSubTitle = UITapGestureRecognizer(target: self, action: "changeSubTitle")
        subtitleLabel.addGestureRecognizer(tabSubTitle)

        subtitleLabel.userInteractionEnabled = true
        self.addSubview(subtitleLabel)
        
        tvStationView = UIImageView(frame: CGRectMake(10, 0, 70 , 50))
        self.addSubview(tvStationView)
        
        charaterView = UIImageView(frame: CGRectMake(10, 0, 80 , 22))
        charaterView.userInteractionEnabled = true
        self.addSubview(charaterView)
        
        charaterLabel = UILabel()
        charaterLabel.font = UIFont.boldSystemFontOfSize(12.0)
        charaterLabel.textColor = UIColor.whiteColor()
        charaterLabel.userInteractionEnabled = true
        charaterView.addSubview(charaterLabel)
        
        var tabCharaterLabel = UITapGestureRecognizer(target: self, action: "changeCharater")
        charaterView.addGestureRecognizer(tabCharaterLabel)
        
        showView = UIImageView(frame: CGRectMake(20, 0, 100 , 100))
        self.addSubview(showView)
        
        tvStationView.contentMode = UIViewContentMode.ScaleAspectFit
        charaterView.contentMode = UIViewContentMode.ScaleToFill
        showView.contentMode = UIViewContentMode.ScaleAspectFit
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSubTitle() {
        if let subtitleChangeAction = subtitleChangeAction {
            subtitleChangeAction()
        }
    }
    
    func changeCharater() {
        if let charaterChangeAction = charaterChangeAction {
            charaterChangeAction()
        }
    }
    
    
    func previewImage() {
        

        subtitleLabel.text = subtitleText
        subtitleLabel.sizeToFit()
        subtitleLabel.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height*0.88)

        tvStationView.image = UIImage(named: "cctv")
        
        charaterLabel.text = charaterText
        charaterLabel.sizeToFit()
        charaterView.frame = CGRectMake(charaterView.frame.origin.x, charaterView.frame.origin.y, 30 + charaterLabel.frame.size.width, 22.0)
        charaterLabel.center = CGPointMake(20 + charaterLabel.frame.size.width/2.0, charaterView.frame.size.height*0.5)

        charaterView.center = CGPointMake(charaterView.center.x, self.frame.size.height*0.88)

        charaterView.image = UIImage(named: "name")
        showView.center = CGPointMake(self.frame.size.height*0.8, self.frame.size.height*0.88)

    }

}

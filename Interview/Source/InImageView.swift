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
        subtitleLabel.font = UIFont.systemFontOfSize(13.0)
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.sizeToFit()
        subtitleLabel.shadowColor = UIColor.blackColor()
        subtitleLabel.shadowOffset = CGSizeMake(1, 1)

        subtitleLabel.userInteractionEnabled = true
        self.addSubview(subtitleLabel)
        
        tvStationView = UIImageView(frame: CGRectMake(10, 0, 50 , 40))
        self.addSubview(tvStationView)
        
        charaterView = UIImageView(frame: CGRectMake(10, 0, 80 , 22))
        self.addSubview(charaterView)
        
        charaterLabel = UILabel()
        charaterLabel.font = UIFont.boldSystemFontOfSize(12.0)
        charaterLabel.textColor = UIColor.whiteColor()
        charaterLabel.userInteractionEnabled = true
        charaterView.addSubview(charaterLabel)
        
        showView = UIImageView(frame: CGRectMake(20, 0, 100 , 100))
        self.addSubview(showView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func previewImage() {
        

        subtitleLabel.text = "当时我就吓尿了"
        subtitleLabel.sizeToFit()
        subtitleLabel.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height*0.88)

        tvStationView.contentMode = UIViewContentMode.ScaleAspectFit
        tvStationView.image = UIImage(named: "cctv")
//        tvStationView.clipsToBounds = true
        
        charaterLabel.text = "市民 叶先生"
        charaterLabel.sizeToFit()
        charaterView.frame = CGRectMake(charaterView.frame.origin.x, charaterView.frame.origin.y, 30 + charaterLabel.frame.size.width, 22.0)
        charaterLabel.center = CGPointMake(20 + charaterLabel.frame.size.width/2.0, charaterView.frame.size.height*0.5)

        charaterView.center = CGPointMake(charaterView.center.x, self.frame.size.height*0.88)
        charaterView.contentMode = UIViewContentMode.ScaleToFill
        charaterView.image = UIImage(named: "name")
        //        tvStationView.clipsToBounds = true

        showView.center = CGPointMake(self.frame.size.height*0.8, self.frame.size.height*0.88)
        showView.contentMode = UIViewContentMode.ScaleAspectFit
        //        tvStationView.clipsToBounds = true

        
    }

}

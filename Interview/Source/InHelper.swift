//
//  InHelper.swift
//  Interview
//
//  Created by kevinzhow on 15/4/29.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

func buttonWith(name: String, image: String, width: CGFloat, height: CGFloat) -> UIButton? {
    var button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    button.frame = CGRectMake(0, 0, width, height)
    button.backgroundColor = defaultLightColor
    button.setTitle(name, forState: UIControlState.Normal)
    button.setTitleColor(UIColor(white: 1.0, alpha: 0.5), forState: UIControlState.Normal)
    button.titleEdgeInsets = UIEdgeInsets(top: 28, left: 0, bottom: 0, right: 0)
    var imageView = UIImageView(image: UIImage(named: image))
    imageView.contentMode = UIViewContentMode.Center
    imageView.frame = CGRect(x: 0, y: 5, width: width, height: height/2.0)
    button.addSubview(imageView)
    button.titleLabel?.font = UIFont.systemFontOfSize(14.0)
    return button
}
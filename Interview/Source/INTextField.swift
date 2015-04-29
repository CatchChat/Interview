//
//  INTextField.swift
//  Interview
//
//  Created by kevinzhow on 15/4/29.
//  Copyright (c) 2015年 kevinzhow. All rights reserved.
//

import UIKit

@IBDesignable
class INTextField: UITextField {
    @IBInspectable var insetX: CGFloat = 15
    @IBInspectable var insetY: CGFloat = 0
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    // placeholder position
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }
    
    // text position
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds , insetX , insetY)
    }
}

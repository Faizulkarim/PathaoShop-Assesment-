//
//  OTColorTheme.swift
//  Pathao Shop
//
//  Created by Md Faizul karim on 23/7/23.
//

import UIKit

struct OTColorTheme: ColorTheme {
    var clearColor: UIColor {
        return .clear
    }
    var colorPrimaryWhite : UIColor? {
        return UIColor.init(named: "PrimaryWhite")
    }
    
    var colorPrimaryBlack : UIColor? {
        return UIColor.init(named: "PrimaryBlack")
    }
    
    var colorPrimaryRed: UIColor? {
        return UIColor.init(named: "PrimaryRed")
    }
    
    
}

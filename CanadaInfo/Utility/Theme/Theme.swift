//
//  Theme.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//


import UIKit.UIFont

class Theme {
    
    class colors{
        class func ciGreen()->UIColor {
            return UIColor(red: 14/255, green: 168/255, blue: 0, alpha: 1)
        }
        class func ciWhite()->UIColor {
            return UIColor.white
        }
        class func ciBlack()->UIColor {
            return UIColor.black
        }
    }
    
    class fonts {
        class func avenirLight(size: CGFloat) -> UIFont {
            return UIFont(name: "Avenir-Light", size: size)!
        }
        class func avenirMedium(size: CGFloat) -> UIFont {
            return UIFont(name: "Avenir-Medium", size: size)!
        }
    }
}

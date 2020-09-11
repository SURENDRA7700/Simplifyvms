//
//  AppTheme.swift
//  Rasedi
//
//  Created by Vijesh on 29/03/2018.
//  Copyright © 2018 DNet. All rights reserved.
//

import Foundation

import Foundation
import UIKit

extension UIColor {
    
    struct Simplify {
        static let Blue : UIColor = #colorLiteral(red: 0.2039215686, green: 0.6509803922, blue: 0.6941176471, alpha: 1)
        static let LightBlue : UIColor = #colorLiteral(red: 0.9215686275, green: 0.9647058824, blue: 0.968627451, alpha: 1)

        static let DarkBlue : UIColor = #colorLiteral(red: 0.2039215686, green: 0.6509803922, blue: 0.6941176471, alpha: 1)
        static let Pink : UIColor = #colorLiteral(red: 0.8235294118, green: 0.3176470588, blue: 0.5176470588, alpha: 1)
        static let Purple : UIColor = #colorLiteral(red: 0.4941176471, green: 0.4117647059, blue: 0.6666666667, alpha: 1)
        static let Green : UIColor = #colorLiteral(red: 0.7137254902, green: 0.7725490196, blue: 0.2156862745, alpha: 1)
        static let Orange : UIColor = #colorLiteral(red: 0.9058823529, green: 0.3254901961, blue: 0.2392156863, alpha: 1)
        static let Black : UIColor = #colorLiteral(red: 0.06274509804, green: 0.07450980392, blue: 0.1137254902, alpha: 1)
        static let borderGray : UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        static let White : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let borderTextColor : UIColor = #colorLiteral(red: 0.8971442908, green: 0.9018413813, blue: 0.9018413813, alpha: 1)
        static let shadowColor : UIColor = #colorLiteral(red: 0.776912868, green: 0.9057471156, blue: 0.92085886, alpha: 1)
        static let errorColor: UIColor = #colorLiteral(red: 0.9584005475, green: 0.2635305524, blue: 0.2104876339, alpha: 1)
        static let redColor: UIColor = #colorLiteral(red: 0.9254901961, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
         static let deleteColor: UIColor = #colorLiteral(red: 0.881408751, green: 0.1437291205, blue: 0.1057908908, alpha: 1)
        static let grayColor : UIColor = #colorLiteral(red: 0.7450318933, green: 0.7451404333, blue: 0.7450081706, alpha: 1)

//        static let errorColor = UIColor(red: 160/255.0, green: 20/255.0, blue: 60/255.0, alpha: 1.0)
        static let successColor = UIColor(red: 48/255.0, green: 174/255.0, blue: 51/255.0, alpha: 1.0)
        static let lineColor : UIColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.6615222393)
        static let backgroundColor : UIColor = #colorLiteral(red: 0.9803064466, green: 0.9804471135, blue: 0.9802758098, alpha: 1)
        static let TabBarSecondColor : UIColor = #colorLiteral(red: 0.5097572207, green: 0.5098339319, blue: 0.5097404122, alpha: 1)
        static let darkColor : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let bgColor : UIColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        static let textColor : UIColor = #colorLiteral(red: 0.2235294118, green: 0.0862745098, blue: 0.2196078431, alpha: 1)
        static let secondaryColor : UIColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
        static let lightBlack : UIColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        static let successGreen : UIColor = #colorLiteral(red: 0.4189913869, green: 0.7477155328, blue: 0.2949719429, alpha: 1)
        static let lightGray : UIColor =  #colorLiteral(red: 0.9468424077, green: 0.9517996978, blue: 0.9517996978, alpha: 0.7415763995)
        static let warningColor : UIColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        static let AlertBgColor : UIColor = #colorLiteral(red: 0.9960784314, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        static let disabledGrayColor : UIColor = #colorLiteral(red: 0.6783706546, green: 0.6784701943, blue: 0.6783489585, alpha: 1)

        

        

    }
    
    
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
    // Helper function to convert from RGB to UIColor
    public func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension UIFont {
    
        static func primaryArabic(size: CGFloat) -> UIFont {
            return UIFont(name: "AJannatLT", size: size)!
        }
//        static func primaryArabicSemiBold(size: CGFloat) -> UIFont {
//            return UIFont(name: "Cairo-SemiBold", size: size)!
//        }
        static func primaryArabicBold(size: CGFloat) -> UIFont {
               return UIFont(name: "AJannatLT-Bold", size: size)!
           }
        
        static func primaryArabicTheMixArab(size: CGFloat) -> UIFont {
                 return UIFont(name: "TheMixArab", size: size)!
        //    return UIFont(name: "Cairo", size: size)!

            }
    
        
        static func primaryEnglish(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize:size)
        }
        
        static func primaryEnglishBold(size: CGFloat) -> UIFont {
            return UIFont.boldSystemFont(ofSize:size)
    //        return UIFont(name: "Cairo-SemiBold", size: size)!
        }
        
       

    
    static func normalSystem(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
}




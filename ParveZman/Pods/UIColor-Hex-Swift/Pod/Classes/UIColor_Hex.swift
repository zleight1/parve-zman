//
//  UIColor_Hex.swift
//  Pods
//
//  Created by Frederik Jacques on 30/05/15.
//
//  This extension is a port of the Objective-C version made by Tom Adriaenssen (@inferis)
//  https://github.com/Inferis/UIColor-Hex
//

import Foundation

public extension String {
    
    func repeat( times:Int) -> String {
        
        var str = self
        
        for character in 1 ..< times {
            str.extend(self)
        }
        
        return str
    }
    
}

public extension UIColor {
    
    /**
    Create an UIColor object based on a CSS color string
    
    :param: css     The CSS color string
    
    :returns: A new UIColor object
    */
    public class func colorWithCSS( var css:String ) -> UIColor {
        
        // If the string is empty, return black color
        if( css.isEmpty ) { return UIColor.blackColor() }
        
        // If the string contains #, remove it from the string
        if( css.hasPrefix("#") ){
            
            css.removeAtIndex(css.startIndex)
            
        }
        
        var redChannel = "0x", greenChannel = "0x", blueChannel = "0x", alphaChannel = "0x"
        var redChannelInt = UInt32(0), greenChannelInt = UInt32(0), blueChannelInt = UInt32(0), alphaChannelInt = UInt32(0)
        var amountOfCharactersInCSSString = count(css)
        
        // Handle different CSS color cases
        switch( amountOfCharactersInCSSString ){
            
        case 1 : // #e => #eeeeeeff
            
            redChannel += css.substringWithRange(Range<String.Index>(start:css.startIndex, end: advance(css.startIndex, 1))).repeat(2)
            greenChannel = redChannel
            blueChannel = redChannel
            alphaChannel += "ff"
            
        case 2 : // #f0 => #f0f0f0ff
            
            redChannel += css.substringWithRange(Range<String.Index>(start:css.startIndex, end: advance(css.startIndex, 2))).repeat(1)
            greenChannel = redChannel
            blueChannel = redChannel
            alphaChannel += "ff"
            
        case 3 : // #123 => #112233ff
            
            redChannel += css.substringWithRange(Range<String.Index>(start:css.startIndex, end: advance(css.startIndex, 1))).repeat(2)
            greenChannel += css.substringWithRange(Range<String.Index>(start:advance(css.startIndex, 1), end: advance(css.startIndex, 2))).repeat(2)
            blueChannel += css.substringWithRange(Range<String.Index>(start:advance(css.startIndex, 2), end: advance(css.startIndex, 3))).repeat(2)
            alphaChannel += "ff"
            
            println("\(redChannel) - \(greenChannel) - \(blueChannel) - \(alphaChannel)")
            
        case 6 : // #123456 => #123456ff
            
            redChannel = css.substringWithRange(Range<String.Index>(start:css.startIndex, end: advance(css.startIndex, 2)))
            greenChannel = css.substringWithRange(Range<String.Index>(start:advance(css.startIndex, 2), end: advance(css.startIndex, 4)))
            blueChannel = css.substringWithRange(Range<String.Index>(start:advance(css.startIndex, 4), end: advance(css.startIndex, 6)))
            alphaChannel += "ff"
            
            
        case 8 : // #12345678 => #12345678
            
            redChannel += css.substringWithRange(Range<String.Index>(start:css.startIndex, end: advance(css.startIndex, 2)))
            greenChannel += css.substringWithRange(Range<String.Index>(start:advance(css.startIndex, 2), end: advance(css.startIndex, 4)))
            blueChannel += css.substringWithRange(Range<String.Index>(start:advance(css.startIndex, 4), end: advance(css.startIndex, 6)))
            alphaChannel += css.substringWithRange(Range<String.Index>(start:advance(css.startIndex, 6), end: advance(css.startIndex, 8)))
            
        default :
            
            return UIColor.redColor()
            
        }
        
        // Create hexadecimal number from the hexadecimal string
        NSScanner(string: redChannel).scanHexInt( &redChannelInt )
        NSScanner(string: greenChannel).scanHexInt( &greenChannelInt )
        NSScanner(string: blueChannel).scanHexInt( &blueChannelInt )
        NSScanner(string: alphaChannel).scanHexInt( &alphaChannelInt )
        
        return UIColor(red: CGFloat(redChannelInt) / 255, green: CGFloat(greenChannelInt) / 255, blue: CGFloat(blueChannelInt) / 255, alpha: CGFloat(alphaChannelInt) / 255)
        
    }
    
    /**
    Create an UIColor object based on a hexadecimal number
    
    :param: hex     The hexadecimal color string
    
    :returns: A new UIColor object
    */
    public class func colorWithHex( hex:UInt ) -> UIColor {
        
        var redChannel, greenChannel, blueChannel:CGFloat
        
        redChannel = CGFloat((hex >> 16) & 0xff) / 0xff
        greenChannel = CGFloat((hex >> 8) & 0xff) / 0xff
        blueChannel = CGFloat((hex >> 0) & 0xff) / 0xff
        
        return UIColor(red: redChannel, green: greenChannel, blue: blueChannel, alpha: 1.0)
        
    }
    
}
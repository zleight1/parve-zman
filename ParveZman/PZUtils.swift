//
//  PZUtils.swift
//  ParveZman
//
//  Created by Zachary Leighton on 5 Tamuz 5775.
//  Copyright (c) 5775 Zachary Leighton. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    func find(includedElement: Element -> Bool) -> Int? {
        for (idx, element) in self.enumerate() {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}

class PZUtils {
    static let sharedInstance = PZUtils();
    
    init() {
        flatRedColor = UIColor.init(hexString: "#F2362C")
        flatBlueColor = UIColor.init(hexString: "#1A7CF9")
        flatGrayColor = UIColor.init(hexString: "#A9A9A9")
        flatGreenColor = UIColor.init(hexString: "#76EE00")
        meatTitle = "Meat Minhag"
        dairyTitle = "Dairy Minhag"
    }

    var flatRedColor: UIColor
    var flatBlueColor: UIColor
    var flatGrayColor: UIColor
    var flatGreenColor: UIColor
    var meatTitle: String
    var dairyTitle: String
}
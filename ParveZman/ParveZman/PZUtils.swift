//
//  PZUtils.swift
//  ParveZman
//
//  Created by Zachary Leighton on 5 Tamuz 5775.
//  Copyright (c) 5775 Zachary Leighton. All rights reserved.
//

import Foundation

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
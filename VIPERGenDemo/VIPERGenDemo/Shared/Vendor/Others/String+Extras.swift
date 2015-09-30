//
//  String+Extras.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 09/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation

extension String
{
    func firstLetterCapitalized() -> String
    {
        if self.isEmpty {
            return self
        }
        else {
            let start = advance(self.startIndex, 0)
            let end = advance(self.startIndex, 1)
            let swiftRange = Range<String.Index>(start: start, end: end)
            return self.stringByReplacingCharactersInRange(swiftRange, withString: self.substringToIndex(advance(self.startIndex, 1)).capitalizedString)
        }
    }
}
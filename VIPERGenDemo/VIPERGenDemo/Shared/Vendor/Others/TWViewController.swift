//
//  TWViewController.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 10/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class TWViewController: UIViewController
{
    override func setNeedsStatusBarAppearanceUpdate() {
        if (self.navigationController != nil) {
            self.navigationController!.setNeedsStatusBarAppearanceUpdate()
        }
        else {
            super.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
//
//  TWNavigationController.swift
//  VIPERGenDemo
//
//  Created by AUTHOR on 10/11/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import UIKit

class TWNavigationController: UINavigationController
{
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.topViewController.preferredStatusBarStyle()
    }
}
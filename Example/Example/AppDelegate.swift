//
//  AppDelegate.swift
//  Example
//
//  Created by Mustafa GUNES on 25.05.2020.
//  Copyright © 2020 Mustafa GUNES. All rights reserved.
//

import UIKit
import RxBatteryManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Monitoring Battery
        Battery.monitor.start()
        
        return true
    }
}


//
//  AppDelegate.swift
//  viper42
//
//  Created by Udo von Eynern on 05.12.18.
//  Copyright © 2018 Udo von Eynern. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let questionsList = QuestionListRouter.init().createQuestionListModule()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = questionsList
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedManager.saveContext()
    }

}


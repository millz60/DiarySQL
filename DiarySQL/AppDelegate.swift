//
//  AppDelegate.swift
//  DiarySQL
//
//  Created by Matt Milner on 7/20/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var managedObjectContext: NSManagedObjectContext!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let navAppearance = UINavigationBar.appearance()
        
        navAppearance.tintColor = UIColor.blueColor()
        navAppearance.barTintColor = UIColor.blueColor()
        navAppearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        let toolbarAppearance = UIToolbar.appearance()
        toolbarAppearance.tintColor = UIColor.blueColor()
        toolbarAppearance.barTintColor = UIColor.blueColor()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        setupCoreData()
        
        guard let navigationController = self.window?.rootViewController as? UINavigationController else {
            fatalError("Root Controller not found")
        }
        
        guard let diaryListController = navigationController.viewControllers.first as? DiaryListTableViewController else{
            fatalError("Diary List Controller not found")
        }
        
        diaryListController.managedObjectContext = self.managedObjectContext
        
        return true
    }
    
    private func setupCoreData() {
        
        
        guard let url = NSBundle.mainBundle().URLForResource("DiaryDataModel", withExtension: "momd") else {
            fatalError("DiaryDataModel not found")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOfURL: url) else {
            fatalError("ManagedObjectModel not found")
        }
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let fileManager = NSFileManager()
        
        guard let documentsURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else {
            fatalError("Documents Directory not found")
        }
        
        let storeURL = documentsURL.URLByAppendingPathComponent("DiaryDatabase.sqlite")
        
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        
        let type = NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType
        
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: type)
        
        self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        
    }
    
    
    
    
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


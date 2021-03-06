//
//  AppDelegate.swift
//  NoughtsAndCrosses
//
//  Created by Julian Hulme on 2016/05/02.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var boardNavigationController: UINavigationController?
    var authorizationNavigationController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // set up landing view controller
        let landingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
        self.authorizationNavigationController = UINavigationController(rootViewController: landingViewController)
        
        // set up board view controller
        let boardViewController = BoardViewController(nibName:"BoardViewController",bundle:nil)
        self.boardNavigationController = UINavigationController(rootViewController: boardViewController)
        self.boardNavigationController?.navigationBarHidden = true
        
        // set up window, and then set the window's root navigation controller to the appropriate nav controller
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("loggedInUser") { // check if logged in already
                self.window?.rootViewController = self.boardNavigationController
        } else {
            self.window?.rootViewController = self.authorizationNavigationController
        }
        self.window?.makeKeyAndVisible()
        
        // initiate the gesture recognizers for the Easter Egg Controller on the app window
        EasterEggController.sharedInstance.initiate(self.window!)
        
        return true
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
    
    // set the app window's root view controller to be the board nav controller
    func navigateToGame() {
        self.window?.rootViewController = self.boardNavigationController
    }
    
    // set the app window's root view controller to be the authorization nav controller
    func navigateToLoggedOutNavigationController() {
        self.window?.rootViewController = self.authorizationNavigationController
    }
    
    // set the app window's root view controller to be the easter egg view controller
    func navigateToEasterEggScreen() {
        let easterEggViewController = EasterEggViewController(nibName: "EasterEggViewController", bundle: nil)
        self.window?.rootViewController = easterEggViewController
    }
    
    // set the app window's root view controller to be the previous navigation controller (before easter egg screen)
    func navigateAwayFromEasterEggScreen() {
        // check if logged in, and navigate back accordingly
        if let _ = NSUserDefaults.standardUserDefaults().objectForKey("loggedInUser") {
            self.window?.rootViewController = self.boardNavigationController
        } else {
            self.window?.rootViewController = self.authorizationNavigationController
        }
    }
    
    // once logged in, move to boardView
    func navigateToLoggedInNavigationController() {
        let boardViewController = BoardViewController(nibName:"BoardViewController",bundle:nil)
        self.boardNavigationController = UINavigationController(rootViewController: boardViewController)
        self.window?.rootViewController = self.boardNavigationController
    }


}


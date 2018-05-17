//
//  AppDelegate.swift
//  serviceApp
//
//  Created by Gourav sharma on 10/24/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//



import UIKit
import CoreData
import IQKeyboardManagerSwift
import CoreData
import GooglePlaces
import GooglePlacePicker
import OneSignal


let Base_URL = "http://recur.mobi/api/v1/"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,OSSubscriptionObserver {

    var window: UIWindow?

    var authToken, userEmail, userName, userPhone, userId, subCatName, selectAddressStr,serviceName, userAddress, otherValue, serviceType, custoProviderId, userType, servicesStr, acticeServiceStatus,modiFyStr,selectedServiceId, PushToken : NSString?

    var oldLattitude, oldLongitude,newLattitude, newLongitude : String?
    
    var oldPlaces, newPlaces : GMSPlace?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
       selectAddressStr = ""

        otherValue = ""
        
        print(selectAddressStr!)
    
    
      GMSPlacesClient.provideAPIKey("AIzaSyDplRT91OpjXDlqxm9FIiNsYRT6ztDLy1c")


        IQKeyboardManager.sharedManager().enable = true
	
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "d07b6532-c1f3-43fd-aaec-5eba635f77ae",
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        OneSignal.add(self as! OSSubscriptionObserver)
        
        self.onRegisterForPushNotificationsButton()

        return true
    }
    func onRegisterForPushNotificationsButton()
    {
        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
        let hasPrompted = status.permissionStatus.hasPrompted
        if hasPrompted == false
        {
            // Call when you want to prompt the user to accept push notifications.
            // Only call once and only if you set kOSSettingsKeyAutoPrompt in AppDelegate to false.
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                if accepted == true
                {
                    print("User accepted notifications: \(accepted)")
                } else {
                    print("User accepted notifications: \(accepted)")
                }
            })
        } else
        {
            
        }
    }
    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
        if !stateChanges.from.subscribed && stateChanges.to.subscribed
        {
            print("Subscribed for OneSignal push notifications!")
        }
        print("SubscriptionStateChange: \n\(stateChanges)")
        
        //The player id is inside stateChanges. But be careful, this value can be nil if the user has not granted you permission to send notifications.
        if let playerId = stateChanges.to.userId
        {
            print("Current playerId \(playerId)")
        }
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        // Print full message.
        print("\(userInfo)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Print full message.
        print("\(userInfo)")
        completionHandler(.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Print message ID.
        let userInfo = notification.request.content.userInfo
        // Print full message.
        print("\(userInfo)")
        // Change this to your preferred presentation option
        completionHandler([])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print full message.
        print("\(userInfo)")
        completionHandler()
    }
    func networkCheck() -> Bool
    {
        let reachability = Reachability()!
        
        if (reachability.isReachable)
        {
            return true
            
        }
        else
        {   return false
            
            
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "serviceApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func showAlert(titleStr:String)
    {
        let alert = UIAlertController(title: "Alert", message: titleStr, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}





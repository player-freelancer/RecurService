//
//  ViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 10/24/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit
import OneSignal
class ViewController: UIViewController
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        
        performSelector(onMainThread: #selector(self.makeMyProgressBarMoving), with: nil, waitUntilDone: false)

        
        
        
    }

    @objc func makeMyProgressBarMoving()
    {
        
        if(UserDefaults.standard.string(forKey: "auth_code") == nil)
        {
            let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            self.navigationController?.pushViewController(CVC, animated: false)
            
        }
        else
        {
            self.appDelegate.userAddress = UserDefaults.standard.string(forKey: "address")! as String as NSString
            
            self.appDelegate.authToken = UserDefaults.standard.string(forKey: "auth_code")! as NSString
            
            self.appDelegate.userName = UserDefaults.standard.string(forKey: "name")! as NSString
            
            self.appDelegate.userEmail = UserDefaults.standard.string(forKey: "email")! as NSString
            
            self.appDelegate.userId = UserDefaults.standard.string(forKey: "UserId")! as NSString
            
            self.appDelegate.userType = UserDefaults.standard.string(forKey: "type")! as NSString
            
            self.appDelegate.servicesStr = UserDefaults.standard.string(forKey: "service")! as NSString
            
            self.navigateToDeshboard()
            
        }
        
        
       
        
        

    }
    func navigateToDeshboard()
    {
        if self.appDelegate.userType == "2"
        {
            if appDelegate.servicesStr == "0"
            {
                UserDefaults.standard.set("", forKey: "bothUser")
                
                let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                CVC.selectService = "2"
                
                self.navigationController?.pushViewController(CVC, animated: true)
                
            }
                
            else
                
            {
                UserDefaults.standard.set("", forKey: "bothUser")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let TSUVC = storyboard.instantiateViewController(withIdentifier: "ProviderHomeViewController")
                let navController = UINavigationController(rootViewController: TSUVC)
                navController.navigationBar.backgroundColor = UIColor.blue
                let leftMenuViewController = SideMenuViewController()
                leftMenuViewController .strF = self.appDelegate.userName! as String;
                
                let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
                navController.navigationBar.isHidden = true
                self.appDelegate.window!.rootViewController! = container!
            }
            
        }
        else if appDelegate.userType == "3"
        {
            
            UserDefaults.standard.set("Customer", forKey: "bothUser")
            UserDefaults.standard.set("yes", forKey: "isCallFromLoginAndSignUp")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let TSUVC = storyboard.instantiateViewController(withIdentifier: "CustDashboardViewController")
            let navController = UINavigationController(rootViewController: TSUVC)
            navController.navigationBar.backgroundColor = UIColor.blue
            let leftMenuViewController = SideMenuViewController()
            leftMenuViewController .strF = self.appDelegate.userName! as String;
            
            let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
            navController.navigationBar.isHidden = true
            self.appDelegate.window!.rootViewController! = container!
            
            
            
            //            let alert = UIAlertController(title: "Alert", message: "Please select user type", preferredStyle: UIAlertControllerStyle.alert)
            //
            //            alert.addAction(UIAlertAction(title: "Provider", style: UIAlertActionStyle.default, handler:
            //                { (UIAlertAction)in
            //
            //     UserDefaults.standard.set("Provider", forKey: "bothUser")
            
            //                    if self.appDelegate.servicesStr == "0"
            //                        {
            //                            let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            //
            //                            CVC.selectService = "2"
            //
            //                            self.navigationController?.pushViewController(CVC, animated: true)
            //                        }
            //
            //                        else
            //
            //                        {
            //                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //                            let TSUVC = storyboard.instantiateViewController(withIdentifier: "ProviderHomeViewController")
            //                            let navController = UINavigationController(rootViewController: TSUVC)
            //                            navController.navigationBar.backgroundColor = UIColor.blue
            //                            let leftMenuViewController = SideMenuViewController()
            //                            leftMenuViewController .strF = self.appDelegate.userName! as String;
            //
            //                            let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
            //                            navController.navigationBar.isHidden = true
            //                            self.appDelegate.window!.rootViewController! = container!
            //                        }
            
            
            
            
            //            }))
            //            alert.addAction(UIAlertAction(title: "Customer", style: UIAlertActionStyle.default, handler:
            //                { (UIAlertAction)in
            //
            //                    UserDefaults.standard.set("Customer", forKey: "bothUser")
            //
            //
            //                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //                        let TSUVC = storyboard.instantiateViewController(withIdentifier: "CustDashboardViewController")
            //                        let navController = UINavigationController(rootViewController: TSUVC)
            //                        navController.navigationBar.backgroundColor = UIColor.blue
            //                        let leftMenuViewController = SideMenuViewController()
            //                        leftMenuViewController .strF = self.appDelegate.userName! as String;
            //
            //                        let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
            //                        navController.navigationBar.isHidden = true
            //                        self.appDelegate.window!.rootViewController! = container!
            //
            //
            //
            //            }))
            //            self.present(alert, animated: true, completion: nil)
            //
            
        }
        else
        {
            UserDefaults.standard.set("", forKey: "bothUser")
            UserDefaults.standard.set("yes", forKey: "isCallFromLoginAndSignUp")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let TSUVC = storyboard.instantiateViewController(withIdentifier: "CustDashboardViewController")
            let navController = UINavigationController(rootViewController: TSUVC)
            navController.navigationBar.backgroundColor = UIColor.blue
            let leftMenuViewController = SideMenuViewController()
            leftMenuViewController .strF = self.appDelegate.userName! as String;
            
            let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
            navController.navigationBar.isHidden = true
            self.appDelegate.window!.rootViewController! = container!
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


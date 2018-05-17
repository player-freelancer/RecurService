//
//  LoginViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 10/24/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit
import OneSignal

class LoginViewController: UIViewController
{
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var forgotBtn: UIButton!
    var hud: YBHud!
    
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
  //  emailTF.text = "gourav.sha13@gmail.com"
  //  passwordTF.text = "123456"
        
     //   emailTF.text = "both@gmail.com"
     //   passwordTF.text = "123456"
       
    //   emailTF.text = "rishu@g.com"
    //   passwordTF.text = "123456"
        
      
        let color: UIColor? = UIColor.white
        
        emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
        forgotBtn.layer.borderWidth = 1.0
        
        forgotBtn.layer.cornerRadius = 20
        
        forgotBtn.layer.borderColor = UIColor.white.cgColor
        
        forgotBtn.clipsToBounds = true
    }
    func handleAddPaymentMethodButtonTapped()
    
    {
        // Setup add card view controller
//        let addCardViewController = STPAddCardViewController()
//        addCardViewController.delegate = self
//
//        // Present add card view controller
//        let navigationController = UINavigationController(rootViewController: addCardViewController)
//        present(navigationController, animated: true)
//
//
        
        
//        let cardParams = STPCardParams()
//        cardParams.number = "424242424242424"
//        cardParams.expMonth = 10
//        cardParams.expYear = 2018
//        cardParams.cvc = "12334"
    
       
//        STPAPIClient.shared().createToken(withCard: cardParams, completion: { (token, error) -> Void in
//            
//            
//            if error != nil
//            {
//                UIAlertView(title: "Please Try Again",
//                            message: error?.localizedDescription,
//                            delegate: nil,
//                            cancelButtonTitle: "OK").show()
//                
//                
//                return
//            }
//            else
//            
//            {
//                  print(token!)
//
//            }
//        })

        
    }
    
    
    
    
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//        // Dismiss add card view controller
//        dismiss(animated: true)
//    }
//
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock)
//    {
//        let strtoken = "\(token)"
//
//        print(strtoken)
//
//        dismiss(animated: true, completion: {() -> Void in
//        })
//
//
//    }
    
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
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTap(_ sender: Any)
    {
        
      
        
        let emailBool:Bool = appDelegate.isValidEmail(testStr: emailTF.text!)
        
        if (emailTF.text == "" && passwordTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter email and password")
            
        }
        else if (emailTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter email for login")
            
        }
        else if (emailBool == false)
        {
            appDelegate.showAlert(titleStr: "Please enter valid email address")
            
        }
            
        else if (passwordTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter password for login")
            
        }
        else
        {
            if (appDelegate.networkCheck() == true)
            {
                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                hud.show(in: view, animated: true)
                
                let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
                
                let pushToken = status.subscriptionStatus.pushToken
                
                let userId = status.subscriptionStatus.userId
                
                //  appDelegate.PushToken = userId as! NSString
                
                if userId == nil
                {
                    appDelegate.PushToken = "12345"
                    
                }
                else
                {
                    appDelegate.PushToken = userId as! NSString
                    
                }
                    
                
                let parametersDicto : NSMutableDictionary? = ["email":emailTF.text ?? "","password":passwordTF.text ?? "","obj_token":appDelegate.PushToken,"obj_type":"ios"]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                let reqUrl = Base_URL + "login?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        self.hud .dismiss(animated: true)
                        
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        print(myDict.value(forKey: "code") as! NSInteger)
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        }
                        else
                        {
                            let array = dic //as! NSArray
                            
                            print(array)
                            
                            UserDefaults.standard.set((dic.value(forKey: "UserId")as AnyObject), forKey: "UserId")
                            
                            UserDefaults.standard.set((dic.value(forKey: "auth_code")as AnyObject), forKey: "auth_code")
                            
                            UserDefaults.standard.set((dic.value(forKey: "email")as AnyObject), forKey: "email")
                            
                            UserDefaults.standard.set(self.passwordTF.text, forKey: "password")

                            
                            UserDefaults.standard.set((dic.value(forKey: "name")as AnyObject), forKey: "name")
                            
                            UserDefaults.standard.set((dic.value(forKey: "address")as AnyObject), forKey: "address")
                            
                            self.appDelegate.userAddress = UserDefaults.standard.string(forKey: "address")! as String as NSString
                            
                            self.appDelegate.authToken = UserDefaults.standard.string(forKey: "auth_code")! as NSString
                            
                            self.appDelegate.userName = UserDefaults.standard.string(forKey: "name")! as NSString
                            
                            self.appDelegate.userEmail = UserDefaults.standard.string(forKey: "email")! as NSString
                            
                            self.appDelegate.userId = UserDefaults.standard.string(forKey: "UserId")! as NSString
                            
                            UserDefaults.standard.set((dic.value(forKey: "service")as AnyObject), forKey: "service")

                            UserDefaults.standard.set((dic.value(forKey: "type")as AnyObject), forKey: "type")
                            
                            self.appDelegate.userType = UserDefaults.standard.string(forKey: "type")! as NSString

                            self.appDelegate.servicesStr = UserDefaults.standard.string(forKey: "service")! as NSString
                            
                          self.navigateToDeshboard()
                        }
                        
                })
            }
            else
            {
                appDelegate.showAlert(titleStr: "Please check your internet connection.")
                
            }
        }
    }
    
    @IBAction func registerTap(_ sender: Any)
    {
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        self.navigationController?.pushViewController(CVC, animated: true)
    }
    
    @IBAction func forgotTap(_ sender: UIButton)
    {
     //   self.handleAddPaymentMethodButtonTapped()
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self .present(CVC, animated: true, completion: nil)
    }
    
}

//
//  SignupViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 10/24/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//



import UIKit
import OneSignal

class SignupViewController: UIViewController,UITextFieldDelegate
{
    var typeStr : NSString = ""
 
    var hud: YBHud!

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var nameTF: UITextField!
    
    @IBOutlet var providerBtn: UIButton!
    
    @IBOutlet var bothBtn: UIButton!
    @IBOutlet var custmerBtn: UIButton!
    
    @IBOutlet var mobileTF: UITextField!
    @IBOutlet var addressTF: UILabel!
    
    @IBOutlet var emailTF: UITextField!
    
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var confirmPasswordTF: UITextField!
    
    @IBAction func SelectAddress(_ sender: UIButton)
    {
    
            
            
            let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        
        if addressTF.text == "Address"
        {
            CVC.selectAddressStr = ""

        }
        else
        
        {
            CVC.selectAddressStr = addressTF.text as! NSString

        }
        
        
            self .present(CVC, animated: true, completion: nil)
            
    }
    override func viewWillAppear(_ animated: Bool)
    {
        if appDelegate.selectAddressStr == ""
        {

        }
        else
        {
            addressTF.text = appDelegate.selectAddressStr! as String

            appDelegate.selectAddressStr = ""

        }
        
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        typeStr = "1";
        
        let color: UIColor? = UIColor(red: 0.0000, green: 0.3529, blue: 0.5569, alpha: 1.0)
        addressTF.text = "Address"
        
        nameTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])

        emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])

        passwordTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
        confirmPasswordTF.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
        
        mobileTF.attributedPlaceholder = NSAttributedString(string: "Mobile", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitTap(_ sender: UIButton)
    {
        
        let emailBool:Bool = appDelegate.isValidEmail(testStr: emailTF.text!)
        
        if (emailTF.text == "" && passwordTF.text == "" && confirmPasswordTF.text == "" && mobileTF.text == "" && addressTF.text == "Address")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields.")
            
        }
        else if (emailTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter email.")
            
        }
        else if (emailBool == false)
        {
            appDelegate.showAlert(titleStr: "Please enter valid email address.")
            
        }
        
       else if (passwordTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter password.")
        }
        else if (confirmPasswordTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter confirm password.")
        }
        else if (passwordTF.text != confirmPasswordTF.text)
        {
            appDelegate.showAlert(titleStr: "password doest not match.")
        }
        else if (addressTF.text == "Address")
        {
            appDelegate.showAlert(titleStr: "Please enter address.")
        }
        else if (mobileTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter mobile number.")
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
                
                let parametersDicto : NSMutableDictionary? = ["name":nameTF.text,"contact_no":mobileTF.text,"gender":"Male","email":emailTF.text,"password":passwordTF.text,"obj_token":appDelegate.PushToken,"obj_type":"ios","type":typeStr,"address":addressTF.text]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                let reqUrl = Base_URL + "register?"
                
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
        ///////////////////// Tab Bar
        
        
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
//            let alert = UIAlertController(title: "Alert", message: "Please select user type", preferredStyle: UIAlertControllerStyle.alert)
//
//            alert.addAction(UIAlertAction(title: "Provider", style: UIAlertActionStyle.default, handler:
//                { (UIAlertAction)in
            
//                    UserDefaults.standard.set("Provider", forKey: "bothUser")
//
//                    if self.appDelegate.servicesStr == "0"
//                    {
//
//                        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//
//                        CVC.selectService = "2"
//
//                        self.navigationController?.pushViewController(CVC, animated: true)
//                    }
//
//                    else
//
//                    {
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let TSUVC = storyboard.instantiateViewController(withIdentifier: "ProviderHomeViewController")
//                        let navController = UINavigationController(rootViewController: TSUVC)
//                        navController.navigationBar.backgroundColor = UIColor.blue
//                        let leftMenuViewController = SideMenuViewController()
//                        leftMenuViewController .strF = self.appDelegate.userName! as String;
//
//                        let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
//                        navController.navigationBar.isHidden = true
//                        self.appDelegate.window!.rootViewController! = container!
//                    }
                    
        
//            }))
//            alert.addAction(UIAlertAction(title: "Customer", style: UIAlertActionStyle.default, handler:
//                { (UIAlertAction)in
//
//                    UserDefaults.standard.set("Customer", forKey: "bothUser")
//
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let TSUVC = storyboard.instantiateViewController(withIdentifier: "CustDashboardViewController")
//                    let navController = UINavigationController(rootViewController: TSUVC)
//                    navController.navigationBar.backgroundColor = UIColor.blue
//                    let leftMenuViewController = SideMenuViewController()
//                    leftMenuViewController .strF = self.appDelegate.userName! as String;
//
//                    let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
//                    navController.navigationBar.isHidden = true
//                    self.appDelegate.window!.rootViewController! = container!
//
//
//
//            }))
//            self.present(alert, animated: true, completion: nil)
//

            UserDefaults.standard.set("Customer", forKey: "bothUser")
            UserDefaults.standard.set("yes", forKey: "isCallFromLoginAndSignUp")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let TSUVC = storyboard.instantiateViewController(withIdentifier: "CustDashboardViewController")
//            TSUVC.isCallFromLoginAndSignUp = true
            let navController = UINavigationController(rootViewController: TSUVC)
            navController.navigationBar.backgroundColor = UIColor.blue
            let leftMenuViewController = SideMenuViewController()
            leftMenuViewController .strF = self.appDelegate.userName! as String;
            
            let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
            navController.navigationBar.isHidden = true
            self.appDelegate.window!.rootViewController! = container!
            
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
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
    }

    @IBAction func coustmerTap(_ sender: UIButton)
    {
        typeStr = "1"
        
        custmerBtn.backgroundColor = UIColor(red: 0.0000, green: 0.3529, blue: 0.5569, alpha: 1.0)

        bothBtn.backgroundColor = UIColor(red: 0.0000, green: 0.6549, blue: 0.8980, alpha: 1)

        providerBtn.backgroundColor = UIColor(red: 0.0000, green: 0.6549, blue: 0.8980, alpha: 1)
        
        //Text Color
        
        
        
//        custmerBtn.titleLabel?.textColor  = UIColor.white;, forState: UIControlState.Normal)
//
//        providerBtn.titleLabel?.textColor  = UIColor(red: 0.0314, green: 0.4196, blue: 1.0000, alpha: 0.5)
//        bothBtn.titleLabel?.textColor  = UIColor(red: 0.0314, green: 0.4196, blue: 1.0000, alpha: 0.5)


    }
    @IBAction func providerTap(_ sender: UIButton)
    {
        typeStr = "2"

        custmerBtn.backgroundColor = UIColor(red: 0.0000, green: 0.6549, blue: 0.8980, alpha: 1)
        
        providerBtn.backgroundColor = UIColor(red: 0.0000, green: 0.3529, blue: 0.5569, alpha: 1.0)
        
        bothBtn.backgroundColor = UIColor(red: 0.0000, green: 0.6549, blue: 0.8980, alpha: 1)
        
        //Text Color
        

    

        
    }
    
    @IBAction func bothTap(_ sender: UIButton)
    {
        typeStr = "3"

        custmerBtn.backgroundColor = UIColor(red: 0.0000, green: 0.6549, blue: 0.8980, alpha: 1)
        
        providerBtn.backgroundColor = UIColor(red: 0.0000, green: 0.6549, blue: 0.8980, alpha: 1)
        
        bothBtn.backgroundColor = UIColor(red: 0.0000, green: 0.3529, blue: 0.5569, alpha: 1.0)
        
        //Text Color
        
        

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backTap(_ sender: UIButton)
    {
        appDelegate.selectAddressStr = ""

        self.navigationController?.popViewController(animated: true)
    }
}

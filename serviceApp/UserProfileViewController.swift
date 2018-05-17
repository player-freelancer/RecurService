//
//  UserProfileViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/26/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var hud: YBHud!

    var iconClick, confirmIconClick : Bool!

    @IBOutlet var confirmPasswordTF: UITextField!
    @IBOutlet var newPasswordTF: UITextField!
    @IBOutlet var mobileTF: UITextField!
    @IBOutlet var addressTF: UILabel!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var titleNameLbl: UILabel!

    @IBOutlet var newPasswordBtn: UIButton!
    
    @IBOutlet var confirnmSeenBtn: UIButton!
    
    @IBOutlet var bothUserBtn: UIButton!
    
    @IBAction func bothUserTap(_ sender: UIButton)
    {
        
        
        if ( mobileTF.text == "" && addressTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields")
            
        }
            
        else if (addressTF.text == "")
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
                
                let parametersDicto : NSMutableDictionary? = ["auth_code":appDelegate.authToken,"contact_no":mobileTF.text,"password":"","miles":"100","service":"ios","address":addressTF.text,"type":"3","name":nameTF.text]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                let reqUrl = Base_URL + "UpdateProfile?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        self.hud .dismiss(animated: true)
                        
                        let dic = (myDict.value(forKey: "response")as   AnyObject) as! NSDictionary
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            
                            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            
                        self.navigationController!.pushViewController(controller, animated: false)

                            let prefs = UserDefaults.standard
                            
                            prefs.removeObject(forKey: "auth_code")

                            prefs.removeObject(forKey: "name")

                            prefs.removeObject(forKey: "email")
                            prefs.removeObject(forKey: "bothUser")


                            self.appDelegate.showAlert(titleStr: "Account updated successfully")

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
    
    @IBAction func addressTap(_ sender: UIButton) {
        
        
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        
        CVC.selectAddressStr = addressTF.text! as NSString
        
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
    
    @IBAction func editTap(_ sender: UIButton)
    {
        
        
        if ( mobileTF.text == "" && addressTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields")
            
        }
        
        else if (addressTF.text == "")
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
                
                let parametersDicto : NSMutableDictionary? = ["auth_code":appDelegate.authToken,"contact_no":mobileTF.text,"password":"","miles":"100","service":"ios","address":addressTF.text,"type":appDelegate.userType,"name":nameTF.text]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                let reqUrl = Base_URL + "UpdateProfile?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        self.hud .dismiss(animated: true)
                        
                        let dic = (myDict.value(forKey: "response")as   AnyObject) as! NSDictionary
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                        
                        self.emailTF.text = dic .object(forKey:
                            "email") as? String
                        
                        self.mobileTF.text = dic .object(forKey:
                            "contact_no") as? String
                        
                        self.nameTF.text = dic .object(forKey:
                            "name") as? String

                        self.titleNameLbl.text = dic .object(forKey:
                            "name") as? String

                        self.addressTF.text = dic .object(forKey:
                            "address") as? String
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "callProfileChange"), object: nil)
                            
                            UserDefaults.standard.set((dic.value(forKey: "name")as AnyObject), forKey: "name")
                            
                            self.appDelegate.userName = UserDefaults.standard.string(forKey: "name")! as NSString
                            
                            UserDefaults.standard.set((dic.value(forKey: "address")as AnyObject), forKey: "address")
                            
                            self.appDelegate.userAddress = UserDefaults.standard.string(forKey: "address")! as String as NSString

                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let TSUVC = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController")
                            let navController = UINavigationController(rootViewController: TSUVC)
                            navController.navigationBar.backgroundColor = UIColor.blue
                            let leftMenuViewController = SideMenuViewController()
                            leftMenuViewController .strF = self.appDelegate.userName! as String;
                            
                            let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
                            navController.navigationBar.isHidden = true
                            self.appDelegate.window!.rootViewController! = container!
                            
                            
                            
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
    
    func getLoadProfileDetail()
    {
        
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            let suthTokenStr = appDelegate.authToken! as String
            
            let reqUrl = Base_URL + "GetProfile/" + suthTokenStr
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    print(myDict)
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "result")as AnyObject)
                    
                    self.emailTF.text = dic .object(forKey:
                        "email") as? String
                    
                    self.mobileTF.text = dic .object(forKey:
                        "contact_no") as? String
                    
                    self.nameTF.text = dic .object(forKey:
                        "name") as? String
                    
                    self.titleNameLbl.text = dic .object(forKey:
                        "name") as? String

                    self.addressTF.text = dic .object(forKey:
                        "address") as? String
                    
                    //    let dic = (myDict.value(forKey: "response")as AnyObject) as! NSDictionary
                    
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")

        }
    }
    
    
    @IBAction func newPaswrdTap(_ sender: UIButton)
    {
            if(iconClick == true)
            {
                newPasswordBtn.setImage(UIImage(named: "protectd passw"), for: .normal)

                
                newPasswordTF.isSecureTextEntry = true
                
                iconClick = false
            }
            else
            {
                newPasswordBtn.setImage(UIImage(named: "eye1"), for: .normal)

                newPasswordTF.isSecureTextEntry = false
                iconClick = true
            }
    
    }
    
    @IBAction func seenConfirmTap(_ sender: UIButton)
    {
        if(confirmIconClick == true)
        {
            confirnmSeenBtn.setImage(UIImage(named: "protectd passw"), for: .normal)

            confirmPasswordTF.isSecureTextEntry = true
            confirmIconClick = false
        }
        else
        {
            confirnmSeenBtn.setImage(UIImage(named: "eye1"), for: .normal)

            confirmPasswordTF.isSecureTextEntry = false
            
            confirmIconClick = true
        }
        
    }
    @IBAction func changePasswordTap(_ sender: UIButton)
    {
        changePasswordView.isHidden = false
     
        backgroundView.isHidden = false
    }
    
    @IBAction func crossTap(_ sender: UIButton)
    {
        changePasswordView.isHidden = true
        
        backgroundView.isHidden = true
    }
    
    @IBAction func resettap(_ sender: UIButton)
    {
        
        self.resetPassword()
        
    }
    
     func resetPassword()
    {
        
    
         if (mobileTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter mobile number.")
        }
        else if (newPasswordTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter new password.")
        }
         else if (confirmPasswordTF.text == "")
         {
            appDelegate.showAlert(titleStr: "Please enter confirm password.")
         }
         else if (newPasswordTF.text != confirmPasswordTF.text)
         {
            appDelegate.showAlert(titleStr: "Password does not match")

         }
        else
        {
            if (appDelegate.networkCheck() == true)
            {
                
                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                
                hud.show(in: view, animated: true)
                
                let parametersDicto : NSMutableDictionary? = ["auth_code":appDelegate.authToken,"contact_no":mobileTF.text,"password":newPasswordTF.text,"miles":"100","service":"ios","address":addressTF.text,"type":"1","name":nameTF.text]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                let reqUrl = Base_URL + "UpdateProfile?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        self.hud .dismiss(animated: true)
                        
                        let dic = (myDict.value(forKey: "response")as   AnyObject) as! NSDictionary
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            
                            self.emailTF.text = dic .object(forKey:
                                "email") as? String
                            
                            self.mobileTF.text = dic .object(forKey:
                                "contact_no") as? String
                            
                            self.nameTF.text = dic .object(forKey:
                                "name") as? String
                            
                            self.titleNameLbl.text = dic .object(forKey:
                                "name") as? String
                            
                            
                            self.addressTF.text = dic .object(forKey:
                                "address") as? String
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "callProfileChange"), object: nil)
                            
                            UserDefaults.standard.set((dic.value(forKey: "name")as AnyObject), forKey: "name")
                            
                            self.appDelegate.userName = UserDefaults.standard.string(forKey: "name")! as NSString
                            
                           // self.changePasswordView.isHidden = true
                            
                          //  self.backgroundView.isHidden = true

                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let TSUVC = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController")
                            let navController = UINavigationController(rootViewController: TSUVC)
                            navController.navigationBar.backgroundColor = UIColor.blue
                            let leftMenuViewController = SideMenuViewController()
                            leftMenuViewController .strF = self.appDelegate.userName! as String;
                            
                            let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
                            navController.navigationBar.isHidden = true
                            self.appDelegate.window!.rootViewController! = container!
                            
                            
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
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var changePasswordView: UIView!
    @IBAction func menuTap(_ sender: UIButton) {
        
        
        let side = SideMenuViewController()
        
        side .strF = appDelegate.userName! as String

        side .receiveTestNotification()
        
        self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
            
            
        })
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let color: UIColor? = UIColor.white
        
        iconClick = false

        confirmIconClick = false


        if appDelegate.userType == "1" || appDelegate.userType == "2"
        {
            bothUserBtn.isHidden = false
        }
        else
        {
            bothUserBtn.isHidden = true

        }
        nameTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
        mobileTF.attributedPlaceholder = NSAttributedString(string: "Mobile", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
                
        emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        newPasswordTF.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        confirmPasswordTF.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])

        
        self.getLoadProfileDetail()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

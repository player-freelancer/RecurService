//
//  srviceConfirmationViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/8/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class NotMovConfirmationViewController: UIViewController
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var hud: YBHud!
    
    var categoryId: String!
    
    var oldAddressStr, dateStr, notesStr, headerStr:NSString!
    
    var  earlyEvaInt : Int!

 //   @IBOutlet var newAddressField: UITextField!
    @IBOutlet var oldAddressField: UILabel!
    @IBOutlet var headerLbl: UILabel!
    
//    @IBOutlet var distance: UITextField!
    
    @IBOutlet var notesTV: UITextView!
    
    @IBOutlet var dateTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        oldAddressField.text = oldAddressStr! as String
        
        notesTV.text = notesStr! as String
        
        dateTF.text = dateStr! as String
        
        headerLbl.text = appDelegate.serviceName as! String
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitTap(_ sender: UIButton)
    {
        
        if (oldAddressField.text == "" && notesTV.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields")
            
        }
        else if (oldAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter address.")
            
        }
            
        else
        {
            if (appDelegate.networkCheck() == true)
            {
                
                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                
                hud.show(in: view, animated: true)
                
                let suthTokenStr = appDelegate.authToken! as String
                
                var parametersDicto : NSMutableDictionary?
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                var reqUrl = ""
                
                if appDelegate.serviceType == "simpleService"
                {
                    if appDelegate.modiFyStr == "modiFy"
                    {
                        parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":oldAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":"1","ServiceId":appDelegate.selectedServiceId]
                        
                        reqUrl = Base_URL + "ModifySingleServicebycustomer"
                    }
                    else
                    
                    {
                        parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":oldAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":"1"]
                        
                        reqUrl = Base_URL + "SaveSingleService"
                    }
                    
                    
            
                }
                else if appDelegate.serviceType == "PUSH PROVIDER PROFILE"
                {
                    
                     parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":oldAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":"1","private_provider":appDelegate.custoProviderId]
                    
                    reqUrl = Base_URL + "PushProviderSingleService"
                    
                }
                else
                {
                    reqUrl = Base_URL + "PushProviderService"
                    
                }
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        
                        self.hud .dismiss(animated: true)
                        
                        
                        print(myDict.value(forKey: "code") as! NSInteger)
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                           
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "error")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            
                            if self.appDelegate.serviceType == "simpleService"
                            {
                                if self.appDelegate.modiFyStr == "modiFy"
                                {
                                    self.appDelegate.modiFyStr = ""
                                    
                                    self.appDelegate.acticeServiceStatus = "active"
                                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                                    
                                    for aViewController in viewControllers
                                    {
                                        if(aViewController is ActiceServiceViewController)
                                        {
                                            self.navigationController!.popToViewController(aViewController, animated: true);
                                        }
                                    }
                                }
                                else
                                    
                                {
                                    
                                
                                
                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                                
                                for aViewController in viewControllers
                                {
                                    if(aViewController is HomeViewController)
                                    {
                                        self.navigationController!.popToViewController(aViewController, animated: true);
                                    }
                                }
                                }
                            }
                            else
                            {
                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                                
                                for aViewController in viewControllers
                                {
                                    if(aViewController is SingleServiceViewController)
                                    {
                                        self.navigationController!.popToViewController(aViewController, animated: true);
                                    }
                                }
                                
                            }
                            self.appDelegate.selectAddressStr = ""

                            self.appDelegate.showAlert(titleStr: "Service Request Submitted")

                            
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
    
    @IBAction func backTap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        if  appDelegate.selectAddressStr != ""
        {
                oldAddressField.text = appDelegate.selectAddressStr! as String
                
            appDelegate.selectAddressStr = ""
            
        }
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



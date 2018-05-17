//
//  ModifyAcceptViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 3/11/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit

class ModifyAcceptViewController: UIViewController
{
    
    var serviceId, serviveTypeStr, serviceNameStr, bidId : String!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var hud: YBHud!
    
    @IBOutlet weak var notesTV: UITextView!
    
    @IBAction func acceptTap(_ sender: UIButton)
    {
        if serviceNameStr == "pause"
        {
            self.callPauseService(resultStr: "accept")
            
        }
        else if serviceNameStr == "finish"
        {
            self.callFinishService(resultStr: "accept")
            
        }
        else
            
        {
            self.callService(resultStr: "accept")
        }
    }
    @IBAction func rejectTap(_ sender: UIButton)
    {
        
        if serviceNameStr == "pause"
        {
            self.callPauseService(resultStr: "reject")
        }
        else if serviceNameStr == "finish"
        {
            self.callFinishService(resultStr: "reject")
            
        }
        else
            
        {
            self.callService(resultStr: "reject")
        }
    }
    
    func callFinishService(resultStr:NSString)
        
        
    {
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            
            let parametersDicto : NSMutableDictionary? = [:]//["auth_code":appDelegate.authToken,"CategoryId":"","SubcategoryId":"","other_val":"","address":"","yard_size":"","notes":notesStr,"recurrence":"","preferredDays":""]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            let suthTokenStr = appDelegate.authToken! as String
            
            if let myChar = notesTV.text.trimmingCharacters(in: .whitespacesAndNewlines) as? String, !myChar.isEmpty {
             
                let totalStr = notesTV.text + "/" + (resultStr as String)
            }
            
            let totalStr = notesTV.text + "/" + (resultStr as String)
            
            var reqUrl = Base_URL + "FinishService/" + suthTokenStr + "/" + serviceId + "/" + totalStr
            
            print(reqUrl)
            
            Webhelper.requestGETservice(reqUrl as String,parameters: parametersDicto!,
                                        completionHandler:
                {
                    
                    (myDict,error) in
                    self.hud .dismiss(animated: true)
                    
                    print(myDict)
                    
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        
                    }
                    else
                    {
                        self.appDelegate.acticeServiceStatus = "active"
                        
                        self.navigationController?.popViewController(animated: true)
                        
                        self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject)
                            as! String))
                    }
                    
                    self.hud .dismiss(animated: true)
                    
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
        
    }
    
    func callPauseService(resultStr:NSString)
        
        
    {
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            
            var parametersDicto : NSMutableDictionary? = [:]//["auth_code":appDelegate.authToken,"CategoryId":"","SubcategoryId":"","other_val":"","address":"","yard_size":"","notes":notesStr,"recurrence":"","preferredDays":""]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            let suthTokenStr = appDelegate.authToken! as String
            
            
            var reqUrl = ""
            
            if appDelegate.userType == "1"
            {
                let totalStr = notesTV.text + "/" + (resultStr as String)
                
                
                reqUrl = Base_URL + "PauseService/" + suthTokenStr + "/" + serviceId + "/" + totalStr
                
                
                Webhelper.requestGETservice(reqUrl as String,parameters: parametersDicto!,
                                            completionHandler:
                    {
                        
                        (myDict,error) in
                        self.hud .dismiss(animated: true)
                        
                        print(myDict)
                        
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            self.appDelegate.acticeServiceStatus = "active"
                            
                            self.navigationController?.popViewController(animated: true)
                            
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject)
                                as! String))
                            
                            
                        }
                        
                        self.hud .dismiss(animated: true)
                        
                        
                        
                })
                
            }
            else
            {
                let totalStr = (resultStr as String)
                
                reqUrl = Base_URL + "PauseServicebycustomer_result?"
                
//                reqUrl = Base_URL + "PauseServicebycustomer_result/" + suthTokenStr + "/" + serviceId + "/" + totalStr

                
                let  parametersDicto = ["auth_code":suthTokenStr,"ServiceId":serviceId,"res_type":resultStr,"notes":notesTV.text] as [String : Any]

                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto as NSDictionary,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        self.hud .dismiss(animated: true)
                        
                        if (error != nil) {

                            self.appDelegate.showAlert(titleStr: (error?.localizedDescription)!)

                        }
                        
                        else{
                            let dic = (myDict.value(forKey: "response")as AnyObject)
                            
                            if (myDict.value(forKey: "code") as! NSInteger) == 201
                            {
                                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                                
                            }
                            else
                            {
                                if self.appDelegate.userType == "1"
                                {
                                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers;
                                    
                                    for aViewController in viewControllers
                                    {
                                        if(aViewController is CustDashboardViewController)
                                        {
                                            self.navigationController!.popToViewController(aViewController, animated: true);
                                        }
                                    }
                                }
                                else
                                {
                                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers;
                                    
                                    for aViewController in viewControllers
                                    {
                                        if(aViewController is ProviderHomeViewController)
                                        {
                                            self.navigationController!.popToViewController(aViewController, animated: true);
                                        }
                                    }
                                }
                                
                                
                                
                                
                                if (dic is NSArray)
                                {
                                    let firstArray:NSArray = dic as! NSArray
                                    
                                    let messageStr = ((firstArray.value(forKey: "message") as AnyObject).object(at: 0) as! NSString)
                                    
                                    self.appDelegate.showAlert(titleStr:messageStr as String)
                                }
                                else
                                {
                                    self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject)
                                        as! String))
                                }
                                
                                
                                
                            }
                        }
                        
                        
                })
                
                
            }
            
            
            
            
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
        
    }
    
    
    
    func callService(resultStr:NSString)
        
        
    {
        if (appDelegate.networkCheck() == true)
        {
            
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            
            hud.show(in: view, animated: true)
            
            var parametersDicto : NSMutableDictionary = [:]
            
            var reqUrl = ""
            
            if appDelegate.userType == "1"
            {
                
                parametersDicto = ["auth_code":appDelegate.authToken,"BidId":self.bidId,"res_type":resultStr,"notes":notesTV.text]
                print(parametersDicto)
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                reqUrl = Base_URL + "ModifyBidbyprovider_result?"
                
                
            }
            else
            {
                
                if serviveTypeStr == "normal"
                {
                    parametersDicto = ["auth_code":appDelegate.authToken,"ServiceId":self.serviceId,"res_type":resultStr,"notes":notesTV.text]
                    
                    
                    reqUrl = Base_URL + "ModifyServicebycustomer_result?"
                    
                }
                else
                {
                    parametersDicto = ["auth_code":appDelegate.authToken,"ServiceId":self.serviceId,"res_type":resultStr,"notes":notesTV.text]
                    
                    reqUrl = Base_URL + "ModifySingleServicebycustomer_result?"
                }
            }
            
            print(reqUrl)
            
            Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto,
                                                   completionHandler:
                {
                    (myDict,error) in
                    
                    print(myDict)
                    
                    self.hud .dismiss(animated: true)
                    
                    if (error != nil) {
                    
                        self.appDelegate.showAlert(titleStr: "Something went wrong with server, please try again.")
                    }
                    else {
                        
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            if self.appDelegate.userType == "1"
                            {
                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers;
                                
                                for aViewController in viewControllers
                                {
                                    if(aViewController is CustDashboardViewController)
                                    {
                                        self.navigationController!.popToViewController(aViewController, animated: true);
                                    }
                                }
                            }
                            else
                            {
                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers;
                                
                                for aViewController in viewControllers
                                {
                                    if(aViewController is ProviderHomeViewController)
                                    {
                                        self.navigationController!.popToViewController(aViewController, animated: true);
                                    }
                                }
                            }
                            
                            if (dic is NSArray)
                            {
                                let firstArray:NSArray = dic as! NSArray
                                
                                let messageStr = ((firstArray.value(forKey: "message") as AnyObject).object(at: 0) as! NSString)
                                
                                self.appDelegate.showAlert(titleStr:messageStr as String)
                            }
                            else
                            {
                                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject)
                                    as! String))
                            }
                        }
                    }
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
    }
    @IBAction func backTap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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

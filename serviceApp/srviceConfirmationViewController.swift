//
//  srviceConfirmationViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/8/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class srviceConfirmationViewController: UIViewController
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var houseView: UIView!
    @IBOutlet var houseTF: UITextField!
    var hud: YBHud!
    
    var categoryId: String!

    var oldAddressStr, newAddresStr, houseStr, distanceStr, dateStr, notesStr:NSString!
    
    var addressInt : Int = 0

    var earlyEvaInt:Int!
    
    @IBOutlet var newSddressView: UIView!
    @IBOutlet var newAddressField: UILabel!
    @IBOutlet var oldAddressField: UILabel!
    @IBOutlet var headerLbl: UILabel!
    
    @IBOutlet var distance: UITextField!

    @IBOutlet var notesTV: UITextView!

    @IBOutlet var dateTF: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        headerLbl.text = appDelegate.serviceName! as String

        oldAddressField.text = oldAddressStr! as String
        
        newAddressField.text = newAddresStr! as String

        distance?.text = distanceStr! as String

        notesTV.text = notesStr! as String

        dateTF.text = dateStr! as String
        
        if  let house = houseStr
        {
            houseTF.text = house as String
        }
        
        headerLbl.text = appDelegate.serviceName! as String
        
        if headerLbl.text == "Gutters"
        {
            houseView .isHidden = false
            
            newSddressView .isHidden = true
        }
        else
        {
            houseView .isHidden = true
            
            newSddressView .isHidden = false
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func submitTap(_ sender: UIButton)
    {
        
        if (oldAddressField.text == "" && newAddressField.text == "" && distance.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields")
            
        }
        else if (oldAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter address.")
            
        }
//        else if (newAddressField.text == "")
//        {
//            
//            
//            appDelegate.showAlert(titleStr: "Please enter Newaddress.")
//            
//        }
            
        else if (distance.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter Distance.")
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
                
                var reqUrl = ""
                
                if appDelegate.serviceType == "simpleService"
                {
                    
                    if headerLbl.text == "Gutters"
                    {
                        
                        if appDelegate.modiFyStr == "modiFy"
                        {
                            reqUrl = Base_URL + "ModifySingleServicebycustomer"
                            
                            parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":oldAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":houseTF.text,"ServiceId":appDelegate.selectedServiceId]

                        }
                        else
                        {
                            reqUrl = Base_URL + "SaveSingleService"

                              parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":oldAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":houseTF.text]
                        }
                      
                    }
                    else
                        
                    {
                        
                        if appDelegate.modiFyStr == "modiFy"
                        {
                            reqUrl = Base_URL + "ModifySingleServicebycustomer"
                            
                            parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":newAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":"","ServiceId":appDelegate.selectedServiceId]

                            
                            
                        }
                        else
                        {

                        reqUrl = Base_URL + "SaveSingleService"

                        
                        parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":newAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":""]
                        }
                    }
                }
                else if appDelegate.serviceType == "PUSH PROVIDER PROFILE"
                {
                    if headerLbl.text == "Gutters"
                    {
                        
                        parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":oldAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":houseTF.text,"private_provider":appDelegate.custoProviderId]
                    }
                    else
                        
                    {
                        parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":newAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":"","private_provider":appDelegate.custoProviderId]
                        
                    }
                    reqUrl = Base_URL + "PushProviderSingleService"
                    
                }
                else
                {
                    if headerLbl.text == "Gutters"
                    {
                        
                        parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":oldAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":houseTF.text,"private_provider":appDelegate.custoProviderId]
                    }
                    else
                        
                    {
                        parametersDicto = ["auth_code":suthTokenStr,"CategoryId":categoryId,"OldAddress":oldAddressField.text,"NewAddress":newAddressField.text,"serviceDate":dateTF.text,"notes":notesTV.text,"EarliestAva":earlyEvaInt,"HouseFeet":"","private_provider":appDelegate.custoProviderId]
                        
                    }
                    reqUrl = Base_URL + "PushProviderSingleService"
                    
                }
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        
                        self.hud .dismiss(animated: true)
                        
                        
                        print(myDict.value(forKey: "code") as! NSInteger)
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
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

                            if self.appDelegate.modiFyStr == "modiFy"
                            {
                                self.appDelegate.modiFyStr = ""

                                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))

                            }
                            else
                            {
                                self.appDelegate.showAlert(titleStr: "Service Request Submitted")

                            }

                            
                            
                            

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

    @IBAction func oldTap(_ sender: UIButton)
    {
        
        addressInt = 1
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        
        CVC.selectAddressStr = oldAddressField.text as! NSString
        
        self .present(CVC, animated: true, completion: nil)
        
    }
    
    @IBAction func newTap(_ sender: UIButton)
    {
        addressInt = 2
        
        
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        
        CVC.selectAddressStr = newAddressField.text as! NSString
        
        self .present(CVC, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        if  appDelegate.selectAddressStr != ""
        {
            if addressInt == 1
            {
                oldAddressField.text = appDelegate.selectAddressStr! as String
                
            }
            else
            {
                newAddressField.text = appDelegate.selectAddressStr! as String
                
            }
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

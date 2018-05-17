//
//  AcceptBidViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 1/2/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit

class AcceptBidViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud: YBHud!
    var reurAmount:String!
    
    var serviceId, serviceFee, bidId, apiType,finalCollectedStr, bidTFStr, notesStr : NSString!
    @IBOutlet var bidAmuntView: UIView!
    @IBOutlet var recurView: UIView!
    @IBOutlet var finalTF: UITextField!
    @IBOutlet var finalView: UIView!
    @IBOutlet var notesTV: UITextView!
    @IBOutlet var notesView: UIView!
    @IBOutlet var recurrTF: UITextField!
    @IBOutlet var bidTF: UITextField!
    @IBOutlet var headerLbl: UILabel!

    @IBAction func backtap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        notesTV.delegate = self
        
        bidTF.delegate = self
        recurrTF.delegate = self
        finalTF.delegate = self

        makePadding(in: bidTF)

        makePadding(in: recurrTF)
        makePadding(in: finalTF)

        
        let color: UIColor? = UIColor.white
        
      //  bidTF.attributedPlaceholder = NSAttributedString(string: "Bid Amount", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
      //  recurrTF.attributedPlaceholder = NSAttributedString(string: "Recurre Fee", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
       // finalTF.attributedPlaceholder = NSAttributedString(string: "Final Collected Amount", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])

        
        
        bidTF.layer.borderWidth = 1.0
        bidTF.layer.cornerRadius = 10
        bidTF.layer.borderColor = UIColor.white.cgColor
        bidTF.clipsToBounds = true
        
        finalTF.layer.borderWidth = 1.0
        finalTF.layer.cornerRadius = 10
        finalTF.layer.borderColor = UIColor.white.cgColor
        finalTF.clipsToBounds = true
    
        recurrTF.layer.borderWidth = 1.0
        recurrTF.layer.cornerRadius = 10
        recurrTF.layer.borderColor = UIColor.white.cgColor
        recurrTF.clipsToBounds = true
        
        notesView.layer.borderWidth = 1.0
        notesView.layer.cornerRadius = 10
        notesView.layer.borderColor = UIColor.white.cgColor
        notesView.clipsToBounds = true
        
        //        addressTF.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
       
        self.loadServices()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    func makePadding(in textfield: UITextField)
    {
        let textVw = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: textfield.frame.size.height))
        textfield.leftView = textVw
        textfield.leftViewMode = .always
    }
    func loadServices()
    {
        
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            let reqUrl = Base_URL + "GetRecurFees"
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        
                        let str = ((myDict.value(forKey: "response")as AnyObject) as! String)
                        
                        if str == "User! Auth Code Expired"
                        {
                            //  Converted to Swift 4 by Swiftify v1.0.6554 - https://objectivec2swift.com/
                            //   var demoController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                            //                            var navigationController: UINavigationController? = menuContainerViewController.centerViewController
                            //                            var controllers = [demoController]
                            //                            navigationController?.viewControllers = controllers as? [UIViewController]
                            //                            menuContainerViewController.menuState = MFSideMenuStateClosed
                            
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        }
                    }
                    else
                    {
                        
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        self.reurAmount = ((dic.value(forKey: "commission")as AnyObject) as! String)
                        
//                        self.recurrTF.text = self.reurAmount  as! String + "%"
                        
                        if self.apiType == "modifyBid"
                        {
                            
                            self.headerLbl.text = "MODIFY BID"
                            
                            
                            self.bidTF?.text = self.bidTFStr as? String
                            
                            self.finalTF?.text = self.finalCollectedStr as? String
                            
                            self.notesTV?.text = self.notesStr as? String

                            
                        }
                        else
                            
                        {
                            
                            self.headerLbl.text = "POST BID"
                            
                        }
                    }
                    //    let dic = (myDict.value(forKey: "response")as AnyObject) as! NSDictionary
                    
                    
                    
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
    }
    override func viewDidLayoutSubviews()
    {
        if (bidTF.text != "")
        {
            let bidAmount = bidTF.text as! String
            
            let cartPaymentPrice = Float(bidAmount)
            
            // 5*20/100
            
            let recur = self.reurAmount as String

            let recurFees = Float(recur)
            
            //
            let currencyDouble: Float = recurFees!
            
            let totalSpending: Float = cartPaymentPrice!
            
            let perCent = currencyDouble*totalSpending/100
            
            let finalValue =  CGFloat(totalSpending - perCent)
            
            
            if finalValue > 0.0
            {
                let finalCollectedStr =  String(format: "%.2f",finalValue) as NSString
                
                finalTF.text = finalCollectedStr as String
                
                let recurStr =  String(format: "$%.2f",perCent) as NSString
                
                recurrTF.text = recurStr as String


            }
            else
            
            {
                finalTF.text = ""
                recurrTF.text = ""

            }
        }
        
        
    }

    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView.text == "Notes"
        {
            textView.text = ""
        }
        else
        {
            
        }
    }
    
    @IBAction func submitTap(_ sender: UIButton)
    {
        
        
//        if ( bidTF.text == "" && recurrTF.text == "")
//        {
//            appDelegate.showAlert(titleStr: "Please enter all fields")
//
//        }
        
       
       // else
        if (bidTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter bid amount.")
        }
       else if finalTF.text == ""
        {
            appDelegate.showAlert(titleStr: "Bid amount should be greater recur fee")
            
        }
        else
        {
            if (appDelegate.networkCheck() == true)
            {
                
                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                
                hud.show(in: view, animated: true)
                
                var parametersDicto : NSMutableDictionary = [:]
                
                var reqUrl = ""
                
                if apiType == "modifyBid"
                {
                    parametersDicto = ["auth_code":appDelegate.authToken ?? "","bid":bidTF.text,"RecurFees":self.reurAmount,"finalCollected":finalTF.text,"service_id":serviceId,"BidId":bidId,"notes":notesTV.text]
                    
                    //  URL: http://dewseekers.com/demo/recur/userapi.php
                    
                     reqUrl = Base_URL + "ModifyBidbyprovider?"
                }
                 else
                {
                     parametersDicto = ["auth_code":appDelegate.authToken,"RecurFees":reurAmount,"bid":bidTF.text,"finalCollected":finalTF.text,"service_id":serviceId,"notes":notesTV.text]
                    
                    //  URL: http://dewseekers.com/demo/recur/userapi.php
                    
                     reqUrl = Base_URL + "PostBid?"
                    
                }
                
              
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        self.hud .dismiss(animated: true)
                        
                       // let dic = (myDict.value(forKey: "response")as   AnyObject) as! NSDictionary
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            if self.apiType == "modifyBid"
                            {
                                 self.appDelegate.acticeServiceStatus = "active"

                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
                                
                                for aViewController in viewControllers
                                {
                                    if(aViewController is UpcomingEventsViewController)
                                    {
                                        self.navigationController!.popToViewController(aViewController, animated: true);
                                    }
                                    else
                                    {
                                        self.navigationController?.popViewController(animated: true)

                                    }
                                }
                            }
                            else
                            {
                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers;
                                
                                self.appDelegate.acticeServiceStatus = "active"

                                for aViewController in viewControllers
                                {
                                    if(aViewController is ProviderHomeViewController)
                                    {
                                        self.navigationController!.popToViewController(aViewController, animated: true);
                                    }
                                }
                            }
                            
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))


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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if (bidTF .isFirstResponder)
        {
            
            
            bidTF.resignFirstResponder()
        }
        return true
    }
    override func didReceiveMemoryWarning()
    {
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

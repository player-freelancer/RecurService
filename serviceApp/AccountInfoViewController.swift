//
//  AccountInfoViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 3/7/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController,UITextFieldDelegate
{

    var hud: YBHud!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var accounTF: UITextField!
    @IBOutlet weak var routingTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!

    @IBAction func tyeTap(_ sender: UIButton)

    {
        let optionMenu = UIAlertController(title: nil, message: "Choose account holder type", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "individual", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.typeTF.text = "individual"
            
            
        })
        let saveAction = UIAlertAction(title: "company", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.typeTF.text = "company"

        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.typeTF.text = ""

        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func saveTap(_ sender: UIButton)
    {
        let accounTFLength: NSString = accounTF.text! as NSString

        let routingTFLenght: NSString = routingTF.text! as NSString

        if (nameTF.text == "" && typeTF.text == "" && routingTF.text == "" && accounTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields.")
            
        }
            
        else if (accounTFLength.length < 12)
        {
            appDelegate.showAlert(titleStr: "Please enter 12 digit account number.")
        }
        else if (routingTFLenght.length < 9)
        {
            appDelegate.showAlert(titleStr: "Please enter 9 digit routing number.")
            
        }
        else if (typeTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter account type.")
        }
        else
        {
            if (appDelegate.networkCheck() == true)
            {
                
                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                
                hud.show(in: view, animated: true)
                
                //  appDelegate.PushToken = userId as! NSString
                
                
                let parametersDicto : NSMutableDictionary? = ["auth_code":appDelegate.authToken,"account_holder_name":nameTF.text,"account_holder_type":typeTF.text as Any,"routing_number":routingTF.text as Any,"account_number":accounTF.text as Any]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                print (parametersDicto)
                
                
                let reqUrl = Base_URL + "create_provider?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        self.hud .dismiss(animated: true)

                        if (error != nil) {
                            self.appDelegate.showAlert(titleStr: (error?.localizedDescription)!)

                        }
                        else {
                            
                            
                            let dic = (myDict.value(forKey: "response")as AnyObject)
                            
                            print(myDict.value(forKey: "code") as! NSInteger)
                            
                            if (myDict.value(forKey: "code") as! NSInteger) == 201
                            {
                                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            }
                            else
                            {
                                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                                
                                self.nameTF.isUserInteractionEnabled = false
                                self.accounTF.isUserInteractionEnabled = false
                                self.typeTF.isUserInteractionEnabled = false
                                self.routingTF.isUserInteractionEnabled = false
                                
                                self.saveBtn.isHidden = true
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
    @IBAction func menuTap(_ sender: UIButton)
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
            // [self setupMenuBarButtonItems];
        })
    }
    func getAccountDetails()
        
    {
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            let suthTokenStr = appDelegate.authToken! as String
            
            let reqUrl = Base_URL + "retreive_bankinfo/" + suthTokenStr
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        //  self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        
                        
                        self.saveBtn.isHidden = false
                    }
                    else
                    {
                        
                        
                        self.nameTF.text = dic .object(forKey:
                            "account_holder_name") as? String
                        
                        self.typeTF.text = dic .object(forKey:
                            "account_holder_type") as? String
                        
                        UserDefaults.standard.set((dic.value(forKey: "account_number")as AnyObject), forKey: "account_number")
                        
                        let accountStr = UserDefaults.standard.string(forKey: "account_number")! as String as NSString
                        
                        self.accounTF.text = accountStr as String
                        //
                        UserDefaults.standard.set((dic.value(forKey: "routing_number")as AnyObject), forKey: "routing_number")
                        
                        let routingStr = UserDefaults.standard.string(forKey: "routing_number")! as String as NSString
                        
                        self.routingTF.text = routingStr as String
                        
                    }
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameTF.delegate = self

        accounTF.delegate = self
        
        routingTF.delegate = self
        
        typeTF.delegate = self
        
        let color: UIColor? = UIColor.white
        
        nameTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        accounTF.attributedPlaceholder = NSAttributedString(string: "Account Number", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        routingTF.attributedPlaceholder = NSAttributedString(string: "Routing Number", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        typeTF.attributedPlaceholder = NSAttributedString(string: "Account Type", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])

        self.getAccountDetails()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == accounTF
        {
            let currentText = textField.text ?? ""
            
            guard let stringRange = Range(range, in: currentText)
                else
                
            {
                return false
            }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            
            return updatedText.count <= 12
        }
            
        else if textField == routingTF
            
        {
            let currentText = textField.text ?? ""
            
            guard let stringRange = Range(range, in: currentText)
                else
                
            {
                return false
            }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            
            return updatedText.count <= 9
        }
        return true
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

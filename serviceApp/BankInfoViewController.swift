//
//  BankInfoViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 2/15/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit
import SwiftLuhn

class BankInfoViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var saveBtn: UIButton!

    @IBOutlet weak var selectBtn: UIButton!

    var validStr: String = ""
    
    var hud: YBHud!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var dateView: UIView!
    
    @IBOutlet weak var datePK: UIDatePicker!
    
    @IBOutlet weak var exDateTF: UITextField!
    @IBOutlet weak var validLbl: UILabel!

    @IBOutlet weak var cvvTF: UITextField!
    @IBOutlet weak var cardTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBAction func menuTap(_ sender: UIButton)
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
            // [self setupMenuBarButtonItems];
        })
    }
    @IBAction func seclectDateTap(_ sender: UIButton)
    {
             dateView.isHidden = false
        
             datePK.minimumDate = Date()
        
            
    }
    
    @IBAction func doneTAp(_ sender: UIButton)
    {
        dateView.isHidden = true
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "MM/yyyy"
        
        let date: String = dateFormat.string(from: datePK.date)
        
        exDateTF.text = date
    }
    
    @IBAction func cancelTap(_ sender: UIButton)
    {
        dateView.isHidden = true
    }
    
    
    @IBAction func saveTap(_ sender: UIButton)
    {
        let cardSTrLength: NSString = cardTF.text! as NSString
        
        if (cardTF.text == "" && exDateTF.text == "" && cvvTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields.")
            
        }
        else if (cardSTrLength.length != 16)
        {
            appDelegate.showAlert(titleStr: "Please enter valid card number.")
        }
        else if (exDateTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please select expiration date")
        }
        else if (cvvTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter CVV Number.")
        }
        else
        {
            if (appDelegate.networkCheck() == true)
            {
                
                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                
                hud.show(in: view, animated: true)
                
                //  appDelegate.PushToken = userId as! NSString
                
                let expiryStr = exDateTF.text
                
                let fullExpiryArray = expiryStr?.components(separatedBy: "/")

                
                let parametersDicto : NSMutableDictionary? = ["auth_code":appDelegate.authToken,"card_number":cardTF.text as Any,"exp_month":fullExpiryArray![0],"exp_year":fullExpiryArray![1],"cvc":cvvTF.text]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                print (parametersDicto)
                
                
                let reqUrl = Base_URL + "create_customer?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        self.hud .dismiss(animated: true)
                        if (error != nil) {
                            self.appDelegate.showAlert(titleStr: (error?.localizedDescription)!)

                        }
                        else{
                            let dic = (myDict.value(forKey: "response")as AnyObject)
                            
                            print(myDict.value(forKey: "code") as! NSInteger)
                            
                            if (myDict.value(forKey: "code") as! NSInteger) == 201
                            {
                                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            }
                            else
                            {
                                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                                
                                self.cardTF.isUserInteractionEnabled = false
                                self.cvvTF.isUserInteractionEnabled = false
                                self.selectBtn.isUserInteractionEnabled = false
                                
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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        validLbl.isHidden = true

        cardTF.delegate = self
        
        cvvTF.delegate = self
        
        let color: UIColor? = UIColor.white
        
        nameTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        cardTF.attributedPlaceholder = NSAttributedString(string: "Card Number(xxxx-xxxx-xxxx-xxxx)", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        exDateTF.attributedPlaceholder = NSAttributedString(string: "Expiration Date", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        cvvTF.attributedPlaceholder = NSAttributedString(string: "CVV Number", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
        self.getCardDetails()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLabel(_ isValid: Bool)
    {
        let currentString: NSString = cardTF.text! as NSString
            as NSString
//        validLbl.isHidden = false
        validLbl.isHidden = true


        if isValid
        {
            
                      validLbl.text = "Valid"

//            if currentString.length == 15
//            {
//                validLbl.text = "Valid"
//
//                validLbl.isHidden = false
//
//            }
//
//            validStr = "Valid"

        }
        else
        {
                           validLbl.text = "IN-Valid"

//            if currentString.length == 15
//            {
//                validLbl.text = "IN-Valid"
//
//                validLbl.isHidden = false
//            }
//                validStr = "IN-Valid"

           
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == cardTF
        {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText)
            else
            
        {
            return false
        }
        

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
            let isValid = updatedText.isValidCardNumber()

            updateLabel(isValid)

        return updatedText.count <= 16
        }
            
        else if textField == cvvTF

        {
            let currentText = textField.text ?? ""
            
            guard let stringRange = Range(range, in: currentText)
                else
                
            {
                return false
            }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        

            return updatedText.count <= 3
        }
        return true
    }
    func getCardDetails()
        
    {
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            let suthTokenStr = appDelegate.authToken! as String

            let reqUrl = Base_URL + "retreive_card/" + suthTokenStr
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                      //  self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        
                        self.cardTF.isUserInteractionEnabled = true
                        self.cvvTF.isUserInteractionEnabled = true
                        self.selectBtn.isUserInteractionEnabled = true

                        self.saveBtn.isHidden = false
                    }
                    else
                    {
                        let array = dic //as! NSArray

                        UserDefaults.standard.set((dic.value(forKey: "last4")as AnyObject), forKey: "last4")
                        
                        UserDefaults.standard.set((dic.value(forKey: "exp_month")as AnyObject), forKey: "exp_month")

                        UserDefaults.standard.set((dic.value(forKey: "exp_year")as AnyObject), forKey: "exp_year")
                        
                        let cardStr = UserDefaults.standard.string(forKey: "last4")! as String as NSString

                        self.cardTF.text = "xxxxxxxxxxxx" + (cardStr as String)

                        self.cvvTF.text = "xxx"
                                                
                        let monthStr = UserDefaults.standard.string(forKey: "exp_month")! as String as NSString
                        
                        let yearStr = UserDefaults.standard.string(forKey: "exp_year")! as String as NSString

                        self.exDateTF.text = (monthStr as String) + "/" + (yearStr as String)
                        
                        self.cardTF.isUserInteractionEnabled = false
                        self.cvvTF.isUserInteractionEnabled = false
                        self.selectBtn.isUserInteractionEnabled = false

                        self.saveBtn.isHidden = true

                        self.validLbl.text = "Valid"
                        
//                        self.validLbl.isHidden = false
                        self.validLbl.isHidden = true

                        
                    }
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if textField == cardTF
//        {
//            let text = (textField.text ?? "") as NSString
//
//            let updatedString = text.replacingCharacters(in: range, with: string)
//
//
//            let maxLength = 15
//            let currentString: NSString = textField.text! as NSString
//                as NSString
//
//            let isValid = updatedString.isValidCardNumber()
//
//            updateLabel(isValid)
//            return currentString.length <= maxLength
//
//        }
//        else if textField == cvvTF
//        {
//            let maxLength = 2
//            let currentString: NSString = textField.text! as NSString
//                as NSString
//            return currentString.length <= maxLength
//        }
//
//        return true
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ForgotPasswordViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/7/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    var hud: YBHud!

    @IBOutlet var emailTF: UITextField!
    
    @IBOutlet var fogetView: UIView!
    @IBAction func submitTap(_ sender: UIButton)
    {
        
        let emailBool:Bool = appDelegate.isValidEmail(testStr: emailTF.text!)
        
        fogetView.layer.borderWidth = 1.0
        fogetView.layer.borderColor = UIColor.white.cgColor
        fogetView.clipsToBounds = true
        
         if (emailTF.text == "")
        {
            showAlert(titleStr: "Please enter email for login")
            
        }
        else if (emailBool == false)
        {
            showAlert(titleStr: "Please enter valid email address")
            
        }
        else
        {
            if (appDelegate.networkCheck() == true)
            {
                emailTF.resignFirstResponder()

                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                
                hud.show(in: view, animated: true)
                
                let parametersDicto : NSMutableDictionary? = ["email":emailTF.text]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                let reqUrl = Base_URL + "forgot-password?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        self.hud .dismiss(animated: true)

                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
else
                        {
                        let alert = UIAlertController(title: "Alert", message: myDict.value(forKey: "response") as? String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
                            
                           
                            self.dismiss(animated: true, completion: nil)

                            
                        }))

                        self.present(alert, animated: true, completion: nil)
                        
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

        var color: UIColor? = UIColor.white
        
        emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func showAlert(titleStr:String)
    {
        let alert = UIAlertController(title: "Alert", message: titleStr, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func backTap(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)

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

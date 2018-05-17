//
//  SelectSingleViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/8/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class NotMoversViewController: UIViewController
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var finalDate : String!

    @IBOutlet var dateView: UIView!
    

    var categoryId: String!
    
    @IBOutlet var headerLbl: UILabel!
    @IBOutlet var notesTV: UITextView!
    @IBOutlet var oldAddressField: UILabel!
    
    @IBOutlet var notesView: UIView!
    @IBOutlet var addressView: UIView!
    @IBOutlet var checkImg: UIImageView!
    
    @IBOutlet var datepicke: UIDatePicker!
    @IBOutlet var selRecuurnceBtn: UIButton!
    @IBAction func selectReccurnce(_ sender: UIButton)
    {
        dateView.isHidden = false
        
        datepicke.minimumDate = Date()
    }
    @IBAction func cancelTap(_ sender: UIButton)
    {
        dateView.isHidden = true
        
    }
    
    @IBAction func doneTap(_ sender: UIButton)
    {
        dateView.isHidden = true
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "dd/MM/yyyy"
        
        let date: String = dateFormat.string(from: datepicke.date)
        
         finalDate = " " + date
        
        selRecuurnceBtn.setTitle(finalDate, for: .normal)
        
        
    }
    
    @IBAction func ealryTap(_ sender: UIButton)
    {
        if checkImg?.image ==  UIImage(named: "Uncheck.png")
        {
            checkImg?.image = UIImage(named: "Checked icon.png")
            
            selRecuurnceBtn.setTitle(" Service Date", for: .normal)
            
        }
        else
        {
            checkImg?.image = UIImage(named: "Uncheck.png")
            
            if finalDate == "" || finalDate == nil
            {
                selRecuurnceBtn.setTitle(" Service Date", for: .normal)
                
            }
            else
            {
                selRecuurnceBtn.setTitle(finalDate, for: .normal)
                
            }
            
        }
        
    }
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        notesView.layer.borderWidth = 1.0
        notesView.layer.cornerRadius = 10

        notesView.layer.borderColor = UIColor.white.cgColor
        notesView.clipsToBounds = true
        //
        
        
        addressView.layer.borderWidth = 1.0
        addressView.layer.cornerRadius = 10

        addressView.layer.borderColor = UIColor.white.cgColor
        addressView.clipsToBounds = true
        
        //
        selRecuurnceBtn.layer.borderWidth = 1.0
        selRecuurnceBtn.layer.cornerRadius = 10

        selRecuurnceBtn.layer.borderColor = UIColor.white.cgColor
        selRecuurnceBtn.clipsToBounds = true
        
      
        // Do any additional setup after loading the view.
        
        headerLbl.text = appDelegate.serviceName! as String
        
        oldAddressField.text = self.appDelegate.userAddress as! String
        
        datepicke.setValue(UIColor.white, forKey: "textColor")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func submitTap(_ sender: UIButton)
    {
        
         if (oldAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter address.")
            
        }
         else if (selRecuurnceBtn.titleLabel?.text == "   Select Recurrence")
         {
            appDelegate.showAlert(titleStr: "Please select Recurrence.")
         }
        else
        {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "NotMovConfirmationViewController") as! NotMovConfirmationViewController
            
            controller.oldAddressStr = oldAddressField.text! as NSString
            let recerStr = selRecuurnceBtn.titleLabel?.text! as! NSString
            
            if recerStr == " Service Date"
            {
                controller.dateStr = "Earliest Available"
                
                controller.earlyEvaInt = 1
                
            }
            else
                
            {
                controller.dateStr = selRecuurnceBtn.titleLabel?.text! as! NSString
                
                controller.earlyEvaInt = 0
                
            }
            
            
            
            controller.notesStr = notesTV.text! as NSString
                        
            controller.categoryId = categoryId
            
            self.navigationController!.pushViewController(controller, animated: true)
            
        }
        
        
    }
    
    @IBAction func backTap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func oldAddressTap(_ sender: UIButton)
    {
        
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        
        if oldAddressField.text == "Address"
            
        {
            CVC.selectAddressStr = ""
        }
        else
        {
            CVC.selectAddressStr = oldAddressField.text as! NSString
            
        }
        self .present(CVC, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        if  appDelegate.selectAddressStr != ""
        {
            oldAddressField.text = appDelegate.selectAddressStr! as String

            appDelegate.selectAddressStr = ""
            
        }
    }
    

    
    @IBOutlet var earlyBtn: UIButton!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


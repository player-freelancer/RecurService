//
//  SelectSingleViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/8/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit
import CoreLocation

class SelectSingleViewController: UIViewController
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    var distanceInMeters: CLLocationDistance = 0.0
    var finalDate : String!
    
    @IBOutlet var dateView: UIView!
    
    @IBOutlet var houseFiledTF: UITextField!

    @IBOutlet var newAddresLbl: UILabel!
    @IBOutlet var houseLbl: UILabel!
    @IBOutlet var housefeetView: UIView!
    var categoryId: String!

    var addressInt : Int = 0
    
    @IBOutlet var headerLbl: UILabel!
    @IBOutlet var notesTV: UITextView!
    @IBOutlet var newAddressField: UILabel!
    @IBOutlet var oldAddressField: UILabel!

    @IBOutlet var notesView: UIView!
    @IBOutlet var neAddressView: UIView!
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

        checkImg?.image = UIImage(named: "Uncheck.png")


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
        
        neAddressView.layer.borderWidth = 1.0
        neAddressView.layer.cornerRadius = 10

        neAddressView.layer.borderColor = UIColor.white.cgColor
        neAddressView.clipsToBounds = true
        
        housefeetView.layer.borderWidth = 1.0
        housefeetView.layer.cornerRadius = 10

        housefeetView.layer.borderColor = UIColor.white.cgColor
        housefeetView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        
        headerLbl.text = appDelegate.serviceName! as String
    
      //  oldAddressField.text = self.appDelegate.userAddress! as String
    
        datepicke.setValue(UIColor.white, forKey: "textColor")

        
        if headerLbl.text == "Gutters"
        {
            housefeetView .isHidden = false
            
            houseLbl .isHidden = false

            newAddresLbl .isHidden = true
            
            neAddressView .isHidden = true
            
        }
        else
        
        {
            housefeetView .isHidden = true
            
            houseLbl .isHidden = true
            
            newAddresLbl .isHidden = false
            
            neAddressView .isHidden = false
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitTap(_ sender: UIButton)
    {
      if headerLbl.text == "Gutters"
      {
        if (oldAddressField.text == "" && newAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields")
            
        }
        else if (oldAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter Old address.")
            
        }
            
        else if (houseFiledTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter House Sq. Ft.")
        }
//        else if (selRecuurnceBtn.titleLabel?.text == "   Select Recurrence")
//        {
//            appDelegate.showAlert(titleStr: "Please select Recurrence.")
//        }
        else
        {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "srviceConfirmationViewController") as! srviceConfirmationViewController
            
            controller.oldAddressStr = oldAddressField.text! as NSString
            
            
            controller.distanceStr = (String(format: "%.1fmiles", (distanceInMeters / 1609.344)) as NSString)
            
            let recerStr = selRecuurnceBtn.titleLabel?.text! as! NSString
            
            if controller.distanceStr == "0.0miles"
            {
                controller.distanceStr = "N/A"
            }
            
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
            
            if headerLbl.text == "Gutters"
            {
                controller.houseStr = houseFiledTF.text as! NSString
                
                controller.newAddresStr = ""


            }
            else
            {
                controller.houseStr = ""
                
                controller.newAddresStr = newAddressField.text as! NSString


            }
            
            controller.categoryId = categoryId
            
            self.navigationController!.pushViewController(controller, animated: true)
            
        }
        
        
      }
        
     else
      {
        
        if (oldAddressField.text == "" && newAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields")
            
        }
        else if (oldAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter address.")
            
        }
        
        else if (newAddressField.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter New address.")
        }
        else if (selRecuurnceBtn.titleLabel?.text == "   Select Recurrence")
        {
            appDelegate.showAlert(titleStr: "Please select Recurrence.")
        }
       else
        {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "srviceConfirmationViewController") as! srviceConfirmationViewController
        
        controller.oldAddressStr = oldAddressField.text! as NSString
        controller.newAddresStr = newAddressField.text! as NSString
            controller.distanceStr = (String(format: "%.1fmiles", (distanceInMeters / 1609.344)) as NSString)
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
    }
    
    @IBAction func backTap(_ sender: UIButton)
    {
        appDelegate.selectAddressStr = ""

        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func oldAddressTap(_ sender: UIButton)
    {
        
        addressInt = 1
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        
        CVC.addressInt = 1

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
            if addressInt == 1
            {
                oldAddressField.text = appDelegate.selectAddressStr! as String

            }
            else
            {
                newAddressField.text = appDelegate.selectAddressStr! as String

            }
            
            if oldAddressField.text != "Address" && newAddressField.text != "New Address"
            {
            let coordinate₀ = CLLocation(latitude: (appDelegate.oldPlaces?.coordinate.longitude)!, longitude: (appDelegate.oldPlaces?.coordinate.longitude)!)
            
            let coordinate₁ = CLLocation(latitude: (appDelegate.newPlaces?.coordinate.longitude)!, longitude: (appDelegate.newPlaces?.coordinate.longitude)!)
            
            distanceInMeters = coordinate₀.distance(from: coordinate₁) // result is in meters
            
                print("Calculated Miles \(String(format: "%.1fmi", (distanceInMeters / 1609.344)))")

                
            print(distanceInMeters)
            
                
                
            appDelegate.selectAddressStr = ""
            }
        }
    }
    
    @IBAction func newAddressTap(_ sender: UIButton)
    {
        addressInt = 2

        
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        CVC.addressInt = 2
        
        if newAddresLbl.text == "New Address"
            
        {
            CVC.selectAddressStr = ""
        }
        else
        {
            CVC.selectAddressStr = newAddresLbl.text as! NSString
            
        }
        self .present(CVC, animated: true, completion: nil)
        
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

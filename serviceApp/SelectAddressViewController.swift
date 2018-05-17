//
//  SelectAddressViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/26/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class SelectAddressViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate {
    
    
    
    @IBOutlet var lawncareSQfootView: UIView!

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var sizeBtn: UIButton!

    @IBOutlet var yardSizeView: UIView!
    @IBOutlet var sizeView: UIView!
    @IBOutlet var selectServiceDayLbl: UILabel!
    @IBOutlet var scrollV: UIScrollView!
    @IBOutlet var acceptBottom: UIButton!
    @IBOutlet var acceptTop: UIButton!
    @IBOutlet var recuringView: UIView!
    @IBOutlet var yardTF: UITextField!
    @IBOutlet var addressTF: UILabel!
    @IBOutlet var notesView: UIView!
    @IBOutlet var yardView: UIView!
    @IBOutlet var addressView: UIView!
    @IBOutlet var notesTV: UITextView!
    @IBOutlet var daysTableV: UITableView!
    
    @IBOutlet var lblSizeType: UILabel!
    @IBOutlet var viewSizeType: UIView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var checkaArray: NSMutableArray = ["Y", "Y","Y","Y","Y","Y","Y"]
    
    var textName : NSMutableArray = ["Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    var selectedDaysArray: NSMutableArray = [1,2,3,4,5,6,7]
    
    var selectedDaysNameArray: NSMutableArray = ["Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    
    @IBOutlet var recurringBtn: UIButton!
    
    @IBOutlet var feetLbl: UILabel!

    
    var hud: YBHud!
    
    var categoryId, subCatId, recurrenceStr,dayStr: String!
    
    var day : Int = 0
    
    @IBAction func sizeTap(_ sender: UIButton)
    {
        recuringView.isHidden = true

        sizeView.isHidden = false
        
    }

    @IBAction func btnSizeTypeTap(_ sender: UIButton) {
        
        viewSizeType.isHidden = false
    }
    
    @IBAction func btnSqaureFeetTap(_ sender: UIButton) {
        lblSizeType.text  = sender.titleLabel?.text
        feetLbl.text = sender.titleLabel?.text
        viewSizeType.isHidden = true
    }
    
    @IBAction func btnAcresTap(_ sender: UIButton) {
        
        lblSizeType.text  = sender.titleLabel?.text
        feetLbl.text = sender.titleLabel?.text
        viewSizeType.isHidden = true
    }
    
    @IBAction func SquareTap(_ sender: UIButton)
    {
        sizeBtn.setTitle(sender.titleLabel?.text, for: .normal)
        
        sizeView.isHidden = true

    }
    
    @IBAction func acresTap(_ sender: UIButton)
    {
        sizeBtn.setTitle(sender.titleLabel?.text, for: .normal)

        sizeView.isHidden = true

    }
    
    @IBAction func threeTap(_ sender: UIButton)
    {
        
        sizeBtn.setTitle(sender.titleLabel?.text, for: .normal)
        
        sizeView.isHidden = true

        
    }
    @IBAction func SelectAddress(_ sender: UIButton)
    {
        
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selectUserAddressViewController") as! selectUserAddressViewController
        
        if addressTF.text == "Address"
            
        {
            CVC.selectAddressStr = ""
        }
        else
        {
            CVC.selectAddressStr = addressTF.text as! NSString
            
        }
        self .present(CVC, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        if  appDelegate.selectAddressStr != ""
        {
            addressTF.text = appDelegate.selectAddressStr! as String
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        notesTV.text = ""
    }
    
    @IBAction func dailyTap(_ sender: UIButton)
    {
        
        recurrenceStr = sender.titleLabel?.text
        
        recurringBtn .setTitle("   " + recurrenceStr, for: .normal)
        
        scrollV.isScrollEnabled = true
        
        recuringView.isHidden = true
        
        acceptTop.isHidden = true
        
        daysTableV.isHidden = false
        
        selectServiceDayLbl.isHidden = false
        
        acceptBottom.isHidden = false
        /*
        checkaArray = ["N", "N","N","N","N","N","N"]
        
        
        selectedDaysArray = []
        
        selectedDaysNameArray = []

         */
        
        checkaArray = ["Y", "Y","Y","Y","Y","Y","Y"]
        selectedDaysArray = [1,2,3,4,5,6,7]
        
        selectedDaysNameArray = ["Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        daysTableV.reloadData()
        
    }
    
    @IBAction func biWeeklyTap(_ sender: UIButton)
    {
        checkaArray = ["N", "N","N","N","N","N","N"]
        
        
        selectedDaysArray = []
        
        selectedDaysNameArray = []
        
        
        recurrenceStr = sender.titleLabel?.text
        
        recurringBtn .setTitle("   " + recurrenceStr, for: .normal)
        
        recuringView.isHidden = true
        
        acceptTop.isHidden = true
        
        daysTableV.isHidden = false
        
        selectServiceDayLbl.isHidden = false
        
        acceptBottom.isHidden = false
        
        scrollV.isScrollEnabled = true
        
        daysTableV.reloadData()
        
    }
    @IBAction func weeklyTap(_ sender: UIButton)
    {
        checkaArray = ["N", "N","N","N","N","N","N"]
        
        
        selectedDaysArray = []
        
        selectedDaysNameArray = []
        
        recurrenceStr = sender.titleLabel?.text
        
        recurringBtn .setTitle("   " + recurrenceStr, for: .normal)
        
        recuringView.isHidden = true
        
        acceptTop.isHidden = true
        
        daysTableV.isHidden = false
        
        selectServiceDayLbl.isHidden = false
        
        acceptBottom.isHidden = false
        
        scrollV.isScrollEnabled = true
        
        daysTableV.reloadData()
        
    }
    
    @IBAction func monthlyTap(_ sender: UIButton)
    {
        checkaArray = ["N", "N","N","N","N","N","N"]
        
        
        selectedDaysArray = []
        
        selectedDaysNameArray = []
        
        recurrenceStr = sender.titleLabel?.text
        
        recurringBtn .setTitle("   " + recurrenceStr, for: .normal)
        
        
        recuringView.isHidden = true
        
        acceptTop.isHidden = true
        
        daysTableV.isHidden = false
        
        selectServiceDayLbl.isHidden = false
        
        acceptBottom.isHidden = false
        
        scrollV.isScrollEnabled = true
        
        daysTableV.reloadData()
        
    }
    @IBAction func otherTap(_ sender: UIButton)
    {   
        checkaArray = ["N", "N","N","N","N","N","N"]
        
        selectedDaysArray = []
        
        selectedDaysNameArray = []
        
        recurrenceStr = sender.titleLabel?.text
        
        recurringBtn .setTitle("   " + recurrenceStr, for: .normal)
        
        recuringView.isHidden = true
        
        acceptTop.isHidden = true
        
        daysTableV.isHidden = false
        
        selectServiceDayLbl.isHidden = false
        
        acceptBottom.isHidden = false
        
        scrollV.isScrollEnabled = true
        
        daysTableV.reloadData()
        
    }
    @IBAction func recuringTap(_ sender: UIButton)
    {
        sizeView.isHidden = true

        recuringView.isHidden = false
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        scrollV.isScrollEnabled = false
        
        daysTableV.delegate = self
        daysTableV.dataSource = self
        
        yardView.layer.borderWidth = 1.0
        yardView.layer.cornerRadius = 10
        yardView.layer.borderColor = UIColor.white.cgColor
        yardView.clipsToBounds = true
        
        //
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
        recurringBtn.layer.borderWidth = 0.5
        recurringBtn.layer.cornerRadius = 10
        
        recurringBtn.layer.borderColor = UIColor.white.cgColor
        recurringBtn.clipsToBounds = true
        
        recuringView.layer.borderWidth = 1.0
        recuringView.layer.borderColor = UIColor.white.cgColor
        recuringView.clipsToBounds = true
        
        
        viewSizeType.layer.borderWidth = 0.5
        viewSizeType.layer.cornerRadius = 10
        viewSizeType.layer.borderColor = UIColor.white.cgColor
        viewSizeType.clipsToBounds = true
        
        sizeView.layer.borderWidth = 0.5
        sizeView.layer.cornerRadius = 10
        sizeView.layer.borderColor = UIColor.white.cgColor
        sizeView.clipsToBounds = true
        
        
        let color: UIColor? = UIColor.white
        
//        addressTF.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        titleLbl.text = appDelegate.serviceName as String?
        
        if titleLbl.text == "Pet Service"
        {
            yardSizeView.isHidden = true

            yardTF.attributedPlaceholder = NSAttributedString(string: "No. Of Pets", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
            
        }
      else if titleLbl.text == "Lawncare"
        {
            yardSizeView.isHidden = true
            
            lawncareSQfootView.isHidden = false

            feetLbl.text = "Square Feet"
            
            yardTF.attributedPlaceholder = NSAttributedString(string: "Approximate Size", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        }

        else if titleLbl.text == "Pool Service"
        {
            yardSizeView.isHidden = true

            yardTF.attributedPlaceholder = NSAttributedString(string: "Pool Size", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
            
        }
            
        else
            
        {
            
            yardSizeView.isHidden = false
            
            feetLbl.text = "Square Feet"

            yardTF.attributedPlaceholder = NSAttributedString(string: "Approximate Size", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
            
        }
        
        
        addressTF?.text = appDelegate.userAddress as String?
        
        notesTV.delegate = self
        
        // Do any additional setup after loading the view.
    }
    @IBAction func acceptTap(_ sender: UIButton)
    {
        
        var isValid = true
        for isCheck  in checkaArray  {
            if isCheck as! String == "Y"
            {
                isValid = false
            }
        }
        if isValid == true{
            appDelegate.showAlert(titleStr: "Please select at least one day")

        }
        
        
       else if (addressTF.text == "" && yardTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter all fields")
            
        }
        else if (addressTF.text == "")
        {
            appDelegate.showAlert(titleStr: "Please enter address.")
            
        }
        else if (yardTF.text == "")
        {
            if titleLbl.text == "Pet Service"
            {
                appDelegate.showAlert(titleStr: "Please enter No. Of Pets.")

            }
            else if titleLbl.text == "Lawncare"
            {
                appDelegate.showAlert(titleStr: "Please enter approximate size")

            }
            else  if titleLbl.text == "Pool Service"
            {
                appDelegate.showAlert(titleStr: "Please enter pool size")
            }
            else
            {
                appDelegate.showAlert(titleStr: "Please enter approximate yard size")

            }
        }
            
        else if (recurrenceStr == nil)
        {
            appDelegate.showAlert(titleStr: "Please select recurrence")
        }
        else
        {
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ServiceDetailViewController") as! ServiceDetailViewController
            
            controller.categoryId = categoryId
            
            controller.subCatId = subCatId
            
            if yardSizeView.isHidden == true
            {
                controller.yardStr = yardTF.text

                controller.floorCount = ""
                controller.strSizeType = lblSizeType.text!
            }
            else
            {
                let yardStr = yardTF.text!
                
                controller.yardStr = yardStr + " " + feetLbl.text!
                
                if (sizeBtn.titleLabel?.text == "Floors")
                {
                    controller.floorCount = "1"

                }
                else
                {
                    controller.floorCount = sizeBtn.titleLabel?.text

                }
                
            }
            controller.addressStr = addressTF.text
            controller.preferredDays = dayStr
            controller.notesStr = notesTV.text
            controller.recuurenceStr = recurrenceStr
            
            let joinedComponents: String = (selectedDaysArray as NSArray).componentsJoined(by: ",")
            
            controller.dayss = joinedComponents
            
            let transferName: String = (selectedDaysNameArray as NSArray).componentsJoined(by: ", ")
            
            controller.daysCount = selectedDaysNameArray.count
            
            controller.dayStr = transferName
            
            controller.categoryId = categoryId
            
            
            
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func backTap(_ sender: UIButton)
    {
        appDelegate.selectAddressStr = ""
        
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
    {
        return textName.count 
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "DaysTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! DaysTableViewCell
        
        
        if (checkaArray.object(at: indexPath.item) as! NSString) == "Y"
        {
            cell.checkImg?.image = UIImage(named: "Checked icon.png")
            
        }
        else
        {
            cell.checkImg?.image = UIImage(named: "Uncheck.png")
            
        }
        cell.dayLbl.text =  textName[indexPath.row] as? String
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        for index in 0..<textName.count
            
        {
            if index == indexPath.row
            {
                
                if (checkaArray.object(at: index) as! NSString) == "Y"
                {
                    self.checkaArray.replaceObject(at: index, with: "N")
                    
                    let  daysName = textName[indexPath.row] as? String
                    
                    let dayCount = indexPath.row
                    
                    selectedDaysNameArray .remove(daysName!)
                    
                    selectedDaysArray .remove(dayCount)
                    
                    
                }
                else
                {
                    self.checkaArray.replaceObject(at: index, with: "Y")
                    
                    let  daysName = textName[indexPath.row] as? String
                    
                    let dayCount = indexPath.row
                    
                    selectedDaysNameArray .add(daysName!)
                    
                    selectedDaysArray .add(dayCount)
                    
                    
                }
                if self.selectedDaysNameArray.count == 1
                {
                    recurrenceStr = "Weekly"
                    
                    recurringBtn .setTitle("   Weekly", for: .normal)
                    
                }
                else if self.selectedDaysNameArray.count == 2
                {
                    recurrenceStr = "Bi-Weekly"
                    
                    recurringBtn .setTitle("   Bi-Weekly", for: .normal)
                    
                }
                else if self.selectedDaysNameArray.count == 7
                {
                    recurrenceStr = "Daily"
                    
                    recurringBtn .setTitle("   Daily", for: .normal)
                    
                }
                else
                {
                    recurrenceStr = "Other"
                    
                    recurringBtn .setTitle("   Other", for: .normal)
                    
                }
            }
            
            
            
            daysTableV.reloadData()
            
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

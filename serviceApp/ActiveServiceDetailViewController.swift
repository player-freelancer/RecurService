 //
 //  ActiveServiceDetailViewController.swift
 //  serviceApp
 //
 //  Created by Gourav sharma on 12/16/17.
 //  Copyright © 2017 Gourav sharma. All rights reserved.
 //
 
 import UIKit
 
 class ActiveServiceDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var serviceTable: UITableView!
    
    var array: NSMutableArray!
    
    var hud: YBHud!
    
    var headerStr, serviceId, recurFeesStr, bidPrice, FinalPrice: String!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var mannulDetailArray:NSArray = []
    
    @IBOutlet var finishBtn: UIButton!
    @IBOutlet var topFinishBtn: UIButton!
    
    @IBOutlet var cancelBtn: UIButton!
    
    @IBOutlet var pauseBtn: UIButton!
    
    @IBOutlet var modifyBtn: UIButton!
    @IBOutlet var dateView: UIView!
    
    @IBOutlet var datepicke: UIDatePicker!
    
    var serviceTypeStr : String?
    
    var dic: AnyObject!
    
    @IBAction func modifyTap(_ sender: UIButton)
    {
        
        if headerStr == "WEEKLY SERVICES" && appDelegate.userType == "2" || appDelegate.userType == "3" && headerStr == "WEEKLY SERVICES"
        {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "AcceptBidViewController") as! AcceptBidViewController
            
            let serviceId = self.dic .object(forKey: "ServiceId") as? String
            
            controller.serviceId = serviceId as! NSString
            
            controller.apiType = "modifyBid"
            
            let bidId = self.dic .object(forKey: "BidId") as? String
            
            controller.bidId = bidId as! NSString
            
            let finalCollected = self.dic .object(forKey: "Finalcollected") as? String
            let notesStr = self.dic .object(forKey: "notes") as? String
            
            let bidTFStr = self.dic .object(forKey: "bid") as? String
            
            controller.finalCollectedStr = finalCollected! as NSString
            
            controller.bidTFStr = bidTFStr! as NSString
            
            controller.notesStr = notesStr! as NSString
            
            
            self.navigationController!.pushViewController(controller, animated: true)
            
            
        }
        else if headerStr == "ACTIVE SERVICES" && appDelegate.userType == "2" || appDelegate.userType == "3" && headerStr == "ACTIVE SERVICES"
        {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "AcceptBidViewController") as! AcceptBidViewController
            
            let serviceId = self.dic .object(forKey: "ServiceId") as? String
            
            controller.serviceId = serviceId as! NSString
            
            controller.apiType = "modifyBid"
            
            let bidId = self.dic .object(forKey: "BidId") as? String
            
            let finalCollected = self.dic .object(forKey: "Finalcollected") as? String
            
            let bidTFStr = self.dic .object(forKey: "bid") as? String
            
            let notesStr = self.dic .object(forKey: "notes") as? String
            
            //   let recurFee = self.dic .object(forKey: "Recurfees") as? String
            
            controller.bidId = bidId as! NSString
            
            controller.finalCollectedStr = finalCollected! as NSString
            
            controller.bidTFStr = bidTFStr! as NSString
            controller.notesStr = notesStr! as NSString
            
            //            controller.bidTF.text =
            self.navigationController!.pushViewController(controller, animated: true)
            
            
            
        }
        else
        {
            appDelegate.serviceType = "simpleService"
            
            appDelegate.modiFyStr = "modiFy"
            
            appDelegate.selectedServiceId = serviceId as! NSString
            
            let serviecType = serviceTypeStr
            
            if serviecType == "normal"
                
            {
                
                let controller = self.storyboard!.instantiateViewController(withIdentifier: "SelectServiceViewController") as! SelectServiceViewController
                
                
                controller.categoryId = self.dic .object(forKey: "CategoryId") as! String
                
                appDelegate.serviceName = self.dic .object(forKey: "category_name") as! NSString
                
                //
                //
                self.navigationController!.pushViewController(controller, animated: true)
                
            }
            else
            {
                let serviceName = self.dic .object(forKey: "category_name") as! String
                
                if serviceName == "Movers" || serviceName == "Gutters"
                    
                {
                    
                    let controller = self.storyboard!.instantiateViewController(withIdentifier: "SelectSingleViewController") as! SelectSingleViewController
                    
                    
                    controller.categoryId = self.dic .object(forKey: "CategoryId") as! String
                    
                    
                    appDelegate.serviceName = self.dic .object(forKey: "category_name") as! NSString
                    
                    //
                    //
                    self.navigationController!.pushViewController(controller, animated: true)
                }
                    
                else
                {
                    
                    let controller = self.storyboard!.instantiateViewController(withIdentifier: "NotMoversViewController") as! NotMoversViewController
                    
                    
                    controller.categoryId = self.dic .object(forKey: "CategoryId") as! String
                    
                    
                    appDelegate.serviceName = self.dic .object(forKey: "category_name") as! NSString
                    
                    //
                    //
                    self.navigationController!.pushViewController(controller, animated: true)
                    
                }
            }
        }
        
    }
    
    @IBAction func cancelTap(_ sender: UIButton)
    {
        
        
        let alert = UIAlertController(title: "Alert", message: "Do you really want to Cancel?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
            { (UIAlertAction)in
                
                if self.headerStr == "WEEKLY SERVICES" && self.appDelegate.userType == "2" || self.appDelegate.userType == "3" && self.headerStr == "WEEKLY SERVICES"
                {
                    
                    
                    
                    self.callService(serviceName: "CancelServiceByProvider/")
                    
                }
                else if self.headerStr == "ACTIVE SERVICES" && self.appDelegate.userType == "2" || self.appDelegate.userType == "3" && self.headerStr == "ACTIVE SERVICES"
                {
                    
                    
                    self.callService(serviceName: "CancelServiceByProvider/")
                }
                else
                {
                    self.callService(serviceName: "CancelService/")
                }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler:
            { (UIAlertAction)in
                
                
                
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func pauseTap(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Alert", message: "Do you really want to Pause?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
            { (UIAlertAction)in
                
                print(self.appDelegate.userType)
                
                if self.headerStr == "WEEKLY SERVICES" && self.appDelegate.userType == "2" || self.appDelegate.userType == "3" && self.headerStr == "WEEKLY SERVICES"
                {
                    self.callService(serviceName: "PauseServiceByProvider/")
                    
                }
                else if self.headerStr == "ACTIVE SERVICES" && self.appDelegate.userType == "2" || self.appDelegate.userType == "3" && self.headerStr == "ACTIVE SERVICES"
                {
                    self.callService(serviceName: "PauseServiceByProvider/")
                    
                }
                else
                {
                    self.callService(serviceName: "PauseServiceByCustomer/")
                    
                }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler:
            { (UIAlertAction)in
                
                
                
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        //     dateView.isHidden = false
        
        //     datepicke.minimumDate = Date()
        
        
        
    }
    @IBAction func TopFinishTap(_ sender: UIButton)
    {
        self.callService(serviceName: "FinishService/")
        
    }
    @IBAction func finishTap(_ sender: UIButton)
    {
        if (headerStr == "Service Detail")
        {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "AcceptBidViewController") as! AcceptBidViewController
            
            //            let serviceId = self.dic .object(forKey: "OldAddress") as? String
            //
            //            controller.serviceId = serviceId as! NSString
            
            let serviceId = self.dic .object(forKey: "ServiceId") as? String
            
            controller.serviceId = serviceId as! NSString
            
            controller.apiType = "PostBid"
            
            self.navigationController!.pushViewController(controller, animated: true)
        }
        else
        {
            if headerStr == "CustomerServices"
            {
                self.navigationController?.popViewController(animated: true)
                
            }
            else
            {
                self.callService(serviceName: "RenewService/")
                
            }
            
            
        }
        
        
    }
    
    func callService(serviceName:NSString)
    {
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            
            let parametersDicto : NSMutableDictionary? = [:]//["auth_code":appDelegate.authToken,"CategoryId":"","SubcategoryId":"","other_val":"","address":"","yard_size":"","notes":notesStr,"recurrence":"","preferredDays":""]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            let suthTokenStr = appDelegate.authToken! as String
            
            let reqUrl = Base_URL + (serviceName as String) + suthTokenStr + "/" + serviceId
            
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
    
    @IBAction func backTap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if headerStr == "ACTIVE SERVICES" && appDelegate.userType == "1" || appDelegate.userType == "3" && headerStr == "ACTIVE SERVICES"
            
        {
            cancelBtn.isHidden = false
            modifyBtn.isHidden = false
            pauseBtn.isHidden = false
            topFinishBtn.isHidden = true
            
            finishBtn.isHidden = true
            
        }
            
            
            
        else if headerStr == "CustomerServices"
        {
            cancelBtn.isHidden = true
            modifyBtn.isHidden = true
            pauseBtn.isHidden = true
            finishBtn.isHidden = false
            topFinishBtn.isHidden = true
            finishBtn .setTitle("Ok", for: .normal)
            
            
        }
        else if headerStr == "WEEKLY SERVICES" && appDelegate.userType == "2"
            || appDelegate.userType == "3" && headerStr == "WEEKLY SERVICES"
        {
            cancelBtn.isHidden = false
            modifyBtn.isHidden = false
            pauseBtn.isHidden = false
            finishBtn.isHidden = true
            topFinishBtn.isHidden = false
            
        }
        else if headerStr == "ACTIVE SERVICES" && appDelegate.userType == "2"
            || appDelegate.userType == "3" && headerStr == "ACTIVE SERVICES"
        {
            cancelBtn.isHidden = false
            modifyBtn.isHidden = false
            pauseBtn.isHidden = false
            finishBtn.isHidden = true
            topFinishBtn.isHidden = false
            
        }
        else if headerStr == "Service Detail"
        {
            cancelBtn.isHidden = true
            modifyBtn.isHidden = true
            pauseBtn.isHidden = true
            finishBtn.isHidden = false
            finishBtn .setTitle("Bid", for: .normal)
            topFinishBtn.isHidden = true
            
            
        }
        else
            
        {
            cancelBtn.isHidden = true
            modifyBtn.isHidden = true
            pauseBtn.isHidden = true
            
            if appDelegate.userType == "1" || appDelegate.userType == "3"
            {
                finishBtn.isHidden = false
                
            }
            else
                
            {
                finishBtn.isHidden = true
                
            }
            topFinishBtn.isHidden = true
            
            
        }
        
        self.getDetalService()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
    {
        return mannulDetailArray.count
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "ServiceDetailTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ServiceDetailTableViewCell
        
        cell.serviecNameLbl?.text = mannulDetailArray[indexPath.row] as! String
        
        
        if self.serviceTypeStr == "single"
            
        {
            if self.dic .object(forKey: "category_name") as? String != "Gutters" &&  self.dic .object(forKey: "category_name") as? String != "Movers"
            {
                
                if indexPath.row == 0
                {
                    //((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString)
                    
                    
                    let categoryNameStr = self.dic .object(forKey:
                        "category_name") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                    
                    
                else if indexPath.row == 1
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "OldAddress") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                    
                else if indexPath.row == 2
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "EarliestAva") as? String
                    
                    if categoryNameStr == "1"
                    {
                        cell.serviceDescLbl?.text = "Earliest Available" as String
                    }
                    else
                    {
                        let categoryNameStr = self.dic .object(forKey: "created_at") as? String
                        
                        cell.serviceDescLbl?.text = categoryNameStr
                        
                    }
                }
                else if indexPath.row == 3
                {
                    
                    let categoryNameStr = self.dic .object(forKey: "bid") as? String
                    if (categoryNameStr == nil)
                    {
                        cell.isHidden = true
                        
                        
                    }
                    else
                    {
                        cell.isHidden = false
                        
                    }
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                
            }
            else
            {
                
                if indexPath.row == 0
                {
                    //((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString)
                    
                    let categoryNameStr = self.dic .object(forKey:
                        "category_name") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 1
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "OldAddress") as? String
                    
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 2
                {
                    if self.dic .object(forKey: "category_name") as? String == "Movers"
                    {
                        let categoryNameStr = self.dic .object(forKey: "NewAddress") as? String
                        
                        cell.serviceDescLbl?.text = categoryNameStr
                    }
                        
                    else if self.dic .object(forKey: "category_name") as? String == "Gutters"
                    {
                        let categoryNameStr = self.dic .object(forKey: "HouseFeet") as? String
                        
                        cell.serviceDescLbl?.text = categoryNameStr
                        
                    }
                        
                    else
                    {
                        let categoryNameStr = self.dic .object(forKey: "user_name") as? String
                        
                        cell.serviceDescLbl?.text = categoryNameStr
                    }
                    
                    
                }
                    
                else if indexPath.row == 3
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "EarliestAva") as? String
                    
                    if categoryNameStr == "1"
                    {
                        cell.serviceDescLbl?.text = "Earliest Available" as String
                    }
                    else
                        
                    {
                        let categoryNameStr = self.dic .object(forKey: "created_at") as? String
                        
                        cell.serviceDescLbl?.text = categoryNameStr
                    }
                }
                else if indexPath.row == 4
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "bid") as? String
                    
                    if (categoryNameStr == nil)
                    {
                        cell.isHidden = true
                    }
                    else
                    {
                        cell.isHidden = false
                        
                    }
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                
            }
        }
            
        else
        {
            let categoryNameStr = self.dic .object(forKey: "category_name") as? String
            
            if categoryNameStr == "Cleaning" {
             
                if indexPath.row == 0
                {
                    //((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString)
                    //   self.mannulDetailArray = ["Service Name","Sub Services","Approximate Size","Address","Recurrence","Days","Service Fees","Provider name","Provider Contact Number"]
                    
                    let categoryNameStr = self.dic .object(forKey: "category_name") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                    
                }
                else if indexPath.row == 1
                    
                {
                    
                    let categoryNameStr = self.dic .object(forKey: "SubcategoryId") as? String
                    
                    if let othervalue = self.dic .object(forKey: "other_val") as? String, !othervalue.isEmpty {
                        
                        cell.serviceDescLbl?.text = categoryNameStr! + "," + othervalue
                        
                    }
                    else {
                        
                        cell.serviceDescLbl?.text = categoryNameStr
                        
                    }
                }
                    
                else if indexPath.row == 2
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "yard_size") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 3
                    
                {
                    if let categoryNameStr = self.dic .object(forKey: "floor_name") as? String, !categoryNameStr.isEmpty {
                        
                        if categoryNameStr == "dummy" {
                            
                            cell.serviceDescLbl?.text = "N/A"
                        }
                        else {
                            
                            cell.serviceDescLbl?.text = categoryNameStr
                        }
                    }
                    else {
                        
                        cell.serviceDescLbl?.text = "N/A"
                    }
                    
                    
                }
                else if indexPath.row == 4
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "address") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 5
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "recurrence") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 6
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "preferredDays") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 7
                {
                    let categoryNameStr = self.dic .object(forKey: "bid") as? String
                    
                    if (categoryNameStr == nil)
                    {
                        cell.isHidden = true
                    }
                    else
                    {
                        cell.isHidden = false
                        
                    }
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                
                
            }
            else {
                if indexPath.row == 0
                {
                    //((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString)
                    //   self.mannulDetailArray = ["Service Name","Sub Services","Approximate Size","Address","Recurrence","Days","Service Fees","Provider name","Provider Contact Number"]
                    
                    let categoryNameStr = self.dic .object(forKey: "category_name") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                    
                }
                else if indexPath.row == 1
                    
                {
                    
                    let categoryNameStr = self.dic .object(forKey: "SubcategoryId") as? String
                    
                    if let othervalue = self.dic .object(forKey: "other_val") as? String, !othervalue.isEmpty {
                        
                        cell.serviceDescLbl?.text = categoryNameStr! + "," + othervalue
                        
                    }
                    else {
                        
                        cell.serviceDescLbl?.text = categoryNameStr
                        
                    }
                }
                    
                else if indexPath.row == 2
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "yard_size") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 3
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "address") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 4
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "recurrence") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 5
                    
                {
                    let categoryNameStr = self.dic .object(forKey: "preferredDays") as? String
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                else if indexPath.row == 6
                {
                    let categoryNameStr = self.dic .object(forKey: "bid") as? String
                    
                    if (categoryNameStr == nil)
                    {
                        cell.isHidden = true
                    }
                    else
                    {
                        cell.isHidden = false
                        
                    }
                    
                    cell.serviceDescLbl?.text = categoryNameStr
                }
                
                
            }
            
            
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        selectedIndexPath = indexPath
        
        
    }
    
    
    func getDetalService()
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "loadPastServices"), object: nil)
        
        
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            //   {{base_url}}/GetBids/{service_id}/{limit}/{offset}
            //  let suthTokenStr = appDelegate.authToken! as String
            
            let suthTokenStr = appDelegate.authToken! as String
            
            
            let reqUrl = Base_URL + "ViewService/" + suthTokenStr + "/" + serviceId
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    print(myDict)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        
                        let str = ((myDict.value(forKey: "response")as AnyObject) as! String)
                        
                        if str == "User! Auth Code Expired"
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        }
                    }
                    else
                    {
                        self.dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        
                        if self.dic.count > 0
                        {
                            
                            let categoryNameStr = self.dic .object(forKey:
                                "category_name") as? String
                            
                            self.serviceTypeStr = (self.dic .object(forKey:
                                "service_type") as? String)
                            
                            
                            if self.serviceTypeStr == "single"
                            {
                                if (categoryNameStr == "Movers")
                                {
                                    
                                    //      1. Service Name 2. Old Address(Movers Only) 3.New Address(Other Single Services) 4.House Feet (Gutters Only) 5. Service Fees 6.Provider name 7. Provider Contact Number
                                    
                                    self.mannulDetailArray = ["Service Name","Old Address","New Address","Service Date","Cost"]
                                    
                                }
                                else  if (categoryNameStr == "Gutters")
                                {
                                    self.mannulDetailArray = ["Service Name","Old Address","House Feet","Service Date","Cost"]
                                    
                                }
                                else
                                {
                                    self.mannulDetailArray = ["Service Name","Old Address","Service Date","Cost"]
                                    
                                }
                                
                            }
                            else
                            {
                                if (categoryNameStr == "Cleaning") {
                                    
                                    self.mannulDetailArray = ["Service Name","Sub Services","Size","Floors","Address","Recurrence","Days","Cost"]
                                }
                                else {
                                    
                                    self.mannulDetailArray = ["Service Name","Sub Services","Size","Address","Recurrence","Days","Cost"]
                                }
                                
                                
                                
                            }
                            
                            self.serviceTable.delegate = self
                            
                            self.serviceTable.dataSource = self
                            
                            self.serviceTable.reloadData()
                            
                        }
                        else
                        {
                            self.appDelegate.showAlert(titleStr: "No detail available!")
                            
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
    
    
    @IBAction func cancelPickerTap(_ sender: UIButton)
    {
        dateView.isHidden = true
        
    }
    
    @IBAction func doneTap(_ sender: UIButton)
    {
        dateView.isHidden = true
        
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "dd/MM/yyyy"
        
        let date: String = dateFormat.string(from: datepicke.date)
        
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
 
 /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
 
 

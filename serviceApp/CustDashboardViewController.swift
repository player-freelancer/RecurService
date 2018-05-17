//
//  CustDashboardViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/10/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class CustDashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    //@IBOutlet var topBtn: DPDropDownMenu!

    var files = ["Lawncare", "Cleaning","Pet Service","Pool Service","Mover","Handyman"]
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud: YBHud!
    var array: NSMutableArray!
    var serviceNameArray: NSArray!
    
    @IBOutlet var btnNotification: UIButton!
    @IBOutlet var newTable: UITableView!
    @IBAction func menuBtnTap(_ sender: UIButton)
    {
        
        self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
            // [self setupMenuBarButtonItems];
        })
        
    }
    @IBAction func bellTap(_ sender: UIButton)
    {
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        self.navigationController!.pushViewController(CVC, animated: true)

    }
    //  Converted with Swiftify v1.0.6472 - https://objectivec2swift.com/
    
    @IBOutlet var dropDownBtn: UIButton!
    
    @IBAction func dropDownTap(_ sender: UIButton)
    {
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.loadServices()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //   NotificationCenter.defaultCenter.addObserver(self, selector: #selector(self.loadServices(_:)), name: "Comparing", object: nil)
        
        if self.appDelegate.acticeServiceStatus == "active"
        {
            self.appDelegate.acticeServiceStatus = ""
            
            self.loadServices()
            
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadServices()
    {
        
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
            
            let reqUrl = Base_URL + "GetCustServices/" + suthTokenStr
            
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
                        
                        let firstArray:NSArray = (dic.value(forKey: "services")as AnyObject) as! NSArray
                        
                        self.array = firstArray.mutableCopy() as! NSMutableArray
                        
                    //    self.serviceNameArray = (dic.value(forKey: "subcategory_name")as AnyObject) as! NSArray

                        
                    //   let singleArray = (dic.value(forKey: "single_services")as AnyObject) as! NSArray
                        
                       // let countValue = firstArray.count + singleArray.count
                        
                      //  for i in firstArray.count..<firstArray.count + singleArray.count
                      //  {

                      //      self.array .add(singleArray[i-firstArray.count])

                    //    }
                       
                           
                        if self.array.count > 0
                        {
                            self.newTable.delegate = self
                            
                            self.newTable.dataSource = self
                            
                            self.newTable.reloadData()
                        }
                        else
                        {
                            
                            if let isCallFromLoginAndSignUp = UserDefaults.standard.value(forKey: "isCallFromLoginAndSignUp") as? String, isCallFromLoginAndSignUp == "no" {
                             
//                                self.appDelegate.showAlert(titleStr:"No Service Available")
                            }
                            
                            self.newTable.delegate = self
                            
                            self.newTable.dataSource = self
                            
                            self.newTable.reloadData()
                        }
                        
                        self.getNotificationCount()
                    }
                    //    let dic = (myDict.value(forKey: "response")as AnyObject) as! NSDictionary
                    
                    
                    
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
    }
    
    
    func getNotificationCount() -> Void {
        
        hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
        hud.dimAmount = 0.7
        hud.show(in: view, animated: true)
        
        let parametersDicto : NSMutableDictionary? = [:]
        
        let suthTokenStr = appDelegate.authToken! as String
        
        let userTypeStr = appDelegate.userType! as String
        
        var reqUrl = ""
        
        if userTypeStr == "3"
        {
            let bothUserStr =  UserDefaults.standard.string(forKey: "bothUser")! as String as NSString
            
            print(bothUserStr)
            
            if bothUserStr == "Customer"
            {
                reqUrl = Base_URL + "notifications/" + suthTokenStr + "/1"
                
            }
            else
            {
                reqUrl = Base_URL + "notifications/" + suthTokenStr + "/2"
                
            }
        }
        else
        {
            reqUrl = Base_URL + "notifications/" + suthTokenStr
            
        }
        
        
        Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                     completionHandler: { (myDict,error) in
                                        
                                        
                                        self.hud .dismiss(animated: true)
                                        
                                        if let dic = myDict as? [String: AnyObject] {
                                            
                                            if let arrNoti = dic["response"] as? [[String: AnyObject]] {
                                                
                                                if !arrNoti.isEmpty {
                                                    
                                                    self.btnNotification.isHidden = false
                                                }
                                                else {
                                                    
                                                    self.btnNotification.isHidden = true
                                                }
                                            }
                                            else {
                                                
                                                self.btnNotification.isHidden = true
                                            }
                                        }
                                        else {
                                            
                                            self.btnNotification.isHidden = true
                                        }
        })
    }
    
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
    {
        return self.array.count
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "costumerDashboardTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! costumerDashboardTableViewCell
        
        let categoryNameStr = (self.array.value(forKey: "category_name") as AnyObject).object(at: indexPath.row) as! NSString
        
        if categoryNameStr == "Movers" || categoryNameStr  == "Handyman" || categoryNameStr == "Gutters" || categoryNameStr == "Other" || categoryNameStr == "Xmas Lights"
        {
            cell.serviceLbl?.text = String(format:"Service: %@",((self.array.value(forKey: "category_name") as AnyObject).object(at: indexPath.row) as! NSString))
            
            
        }
        else
        {
            let subCatname = ((self.array.value(forKey: "subcatID") as AnyObject).object(at: indexPath.row) as! NSString)
            
            let fullNameArr = subCatname.components(separatedBy: ",")
           
            var characters = "Service: " + ((categoryNameStr as NSString) as String) + "\n"
            
             for i in 0..<fullNameArr.count
             {
                if i == 0
                {
                    if fullNameArr[i] == "1"
                    {
                        characters = "\(characters)\("Mow")" as String
                        
                    }
                    else if fullNameArr[i] == "2"
                    {
                        characters = "\(characters)\("Edge")" as String
                        
                        
                    }
                    else if fullNameArr[i] == "3"
                    {
                        characters = "\(characters)\("Blow")" as String
                        
                    }
                    else if fullNameArr[i] == "4"
                    {
                        characters = "\(characters)\("Bag")" as String
                        
                    }
                    else if fullNameArr[i] == "5"
                    {
                        characters = "\(characters)\("Trim Bushes")" as String
                        
                    }
                        
                    else if fullNameArr[i] == "6"
                    {
                        characters = "\(characters)\("Sweep Floors")" as String
                        
                        
                    }
                    else if fullNameArr[i] == "7"
                    {
                        characters = "\(characters)\("Mop Floors")" as String
                        
                    }
                    else if fullNameArr[i] == "8"
                    {
                        characters = "\(characters)\("Windows")" as String
                        
                        
                    }
                    else if fullNameArr[i] == "9"
                    {
                        characters = "\(characters)\("Dust")" as String
                        
                    }
                    else if fullNameArr[i] == "10"
                    {
                        characters = "\(characters)\("Bathrooms")" as String
                        
                        
                    }else if fullNameArr[i] == "11"
                    {
                        characters = "\(characters)\("Kitchen")" as String
                        
                        
                    }
                    else if fullNameArr[i] == "12"
                    {
                        characters = "\(characters)\("Walk")" as String
                        
                    }
                    else if fullNameArr[i] == "13"
                    {
                        characters = "\(characters)\("Feed")" as String
                        
                    }
                    else if fullNameArr[i] == "14"
                    {
                        characters = "\(characters)\("Grooming")" as String
                        
                    }
                    else if fullNameArr[i] == "15"
                    {
                        characters = "\(characters)\("Visit/Pay")" as String
                        
                    }
                    else if fullNameArr[i] == "16"
                    {
                        characters = "\(characters)\("Clean, Net, Vacuum")" as String
                        
                    }
                    else if fullNameArr[i] == "17"
                    {
                        characters = "\(characters)\("Balance Chemicals")" as String
                        
                        
                    }
                    else if fullNameArr[i] == "18"
                    {
                        characters = "\(characters)\("Maintain Equipment")" as String
                        
                    }
                }
               else
                    
                {
                if fullNameArr[i] == "1"
                {
                    characters = "\(characters)\(", Mow")" as String

                }
                else if fullNameArr[i] == "2"
                {
                    characters = "\(characters)\(", Edge")" as String


                }
                else if fullNameArr[i] == "3"
                {
                    characters = "\(characters)\(", Blow")" as String

                }
                else if fullNameArr[i] == "4"
                {
                    characters = "\(characters)\(", Bag")" as String

                }
                else if fullNameArr[i] == "5"
                {
                    characters = "\(characters)\(", Trim Bushes")" as String

                }
               
                else if fullNameArr[i] == "6"
                {
                    characters = "\(characters)\(", Sweep Floors")" as String


                }
                else if fullNameArr[i] == "7"
                {
                    characters = "\(characters)\(", Mop Floors")" as String

                }
                else if fullNameArr[i] == "8"
                {
                    characters = "\(characters)\(", Windows")" as String


                }
                else if fullNameArr[i] == "9"
                {
                    characters = "\(characters)\(", Dust")" as String

                }
                else if fullNameArr[i] == "10"
                {
                    characters = "\(characters)\(", Bathrooms")" as String


                }else if fullNameArr[i] == "11"
                {
                    characters = "\(characters)\(", Kitchen")" as String


                }
                else if fullNameArr[i] == "12"
                {
                    characters = "\(characters)\(", Walk")" as String

                }
                else if fullNameArr[i] == "13"
                {
                    characters = "\(characters)\(", Feed")" as String

                }
                else if fullNameArr[i] == "14"
                {
                    characters = "\(characters)\(", Grooming")" as String

                }
                else if fullNameArr[i] == "15"
                {
                    characters = "\(characters)\(", Visit/Pay")" as String

                }
                else if fullNameArr[i] == "16"
                {
                    characters = "\(characters)\(", Clean, Net, Vacuum")" as String

                }
                else if fullNameArr[i] == "17"
                {
                    characters = "\(characters)\(", Balance Chemicals")" as String


                }
                else if fullNameArr[i] == "18"
                {
                    characters = "\(characters)\(", Maintain Equipment")" as String
                    
                }
            }
            }
            
            
            cell.serviceLbl?.text = characters as? String

        }
//
        cell.infoBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        cell.infoBtn.tag = indexPath.row
        
        cell.bidCountLbl?.text = String(format:"Number of Bids: %@",((self.array.value(forKey: "count_bid") as AnyObject).object(at: indexPath.row) as! NSString))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "BidListViewController") as! BidListViewController
        
        controller.bidId = ((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)
        
        let earlyStr = ((self.array.value(forKey: "Type") as AnyObject).object(at: indexPath.row) as! NSString)
        
        
        if earlyStr == "Single"
        {
            controller.preferredDaysStr = ((self.array.value(forKey: "serviceDate") as AnyObject).object(at: indexPath.row) as! NSString)

        }
        else
        {
            controller.preferredDaysStr = ((self.array.value(forKey: "preferredDays") as AnyObject).object(at: indexPath.row) as! NSString)

        }

        
        self.navigationController!.pushViewController(controller, animated: true)
        
    }
    @objc func buttonPressed(sender:UIButton)
    {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiveServiceDetailViewController") as! ActiveServiceDetailViewController
        
        controller.headerStr = "CustomerServices"
 
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: sender.tag) as! NSString)) as String!
    
        self.navigationController!.pushViewController(controller, animated: true)

    }
   
   // 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ActiceServiceViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/14/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit
class ActiceServiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var headerLbl: UILabel!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud: YBHud!
    var array: NSMutableArray!

    @IBOutlet var menuBtn: UIButton!
    @IBOutlet var activeTable: UITableView!
    
    @IBAction func backtap(_ sender: UIButton)
    {
      if  headerLbl.text == "WEEKLY SERVICES"
      {
        self.navigationController?.popViewController(animated: true)

      }
        else
            {
            self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
                    // [self setupMenuBarButtonItems];
                })
            }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
     if UserDefaults.standard.string(forKey: "Comparing") == "Past"
     {
        
        headerLbl.text = "PAST SERVICES"
        
        menuBtn.setImage(UIImage(named: "Menu"), for: .normal)

        self.loadPastServices()
        
     }
    else if UserDefaults.standard.string(forKey: "Comparing") == "weekly"
    {
        headerLbl.text = "WEEKLY SERVICES"
            
        menuBtn.setImage(UIImage(named: "Back"), for: .normal)
            
        self.loadWeeklyServices()
    }
    else
     {
        headerLbl.text = "ACTIVE SERVICES"

        menuBtn.setImage(UIImage(named: "Menu"), for: .normal)

        self.loadServices()
     }

  }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //   NotificationCenter.defaultCenter.addObserver(self, selector: #selector(self.loadServices(_:)), name: "Comparing", object: nil)
        
        if self.appDelegate.acticeServiceStatus == "active"
        {
            appDelegate.modiFyStr = ""

            self.appDelegate.acticeServiceStatus = ""
            
            if headerLbl.text == "PAST SERVICES"
            {
                self.loadPastServices()
            }
            else
            {
                self.loadServices()
            }
            
        }
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func loadWeeklyServices()
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
            
            //  http://recur.mobi/api/v1//72fd06d297945e4200960f38770c6683
            
            let date : Date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let todaysDate = dateFormatter.string(from: date)
            
            print(todaysDate)
            
            let reqUrl = Base_URL + "GetAppointmentsDay/" + suthTokenStr + "/" + todaysDate

            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        
                        let str = ((myDict.value(forKey: "response")as AnyObject) as! String)

                        self.activeTable.isHidden = true
                        
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        
                    }
                    else
                    {
                        
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        let firstArray:NSArray = dic as! NSArray
                        
                        self.array = firstArray.mutableCopy() as! NSMutableArray
                        
                        // let countValue = firstArray.count + singleArray.count
                        
                        
                        
                        
                        print(self.array)
                        if self.array.count > 0
                        {
                            
                            self.activeTable.delegate = self
                            
                            self.activeTable.dataSource = self
                            
                            self.activeTable.reloadData()
                        }
                        else
                        {
                            self.appDelegate.showAlert(titleStr:"No Service Available")
                            
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
    
    @objc func loadPastServices()
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
            
            //  http://recur.mobi/api/v1//72fd06d297945e4200960f38770c6683
            
            let reqUrl = Base_URL + "GetPastServices/" + suthTokenStr
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        
                        let str = ((myDict.value(forKey: "response")as AnyObject) as! String)
                        
                        self.activeTable.isHidden = true

                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                    
                    }
                    else
                    {
                        
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        let firstArray:NSArray = dic as! NSArray
                        
                        self.array = firstArray.mutableCopy() as! NSMutableArray
                        
                        // let countValue = firstArray.count + singleArray.count
                        
                        
                        
                        
                        print(self.array)
                        if self.array.count > 0
                        {
                            
                            self.activeTable.delegate = self
                            
                            self.activeTable.dataSource = self
                            
                            self.activeTable.reloadData()
                        }
                        else
                        {
                            self.appDelegate.showAlert(titleStr:"No Past Services")
                            
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
    
    @objc func loadServices()
    {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "loadServices"), object: nil)

        
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
            
          //  http://recur.mobi/api/v1//72fd06d297945e4200960f38770c6683

            let reqUrl = Base_URL + "GetActiveServices/" + suthTokenStr
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        
                        let str = ((myDict.value(forKey: "response")as AnyObject) as! String)

                        self.activeTable.isHidden = true

                        self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        
                    }
                    else
                    {
                        
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        let firstArray:NSArray = dic as! NSArray
                        
                        self.array = firstArray.mutableCopy() as! NSMutableArray
                        
                        // let countValue = firstArray.count + singleArray.count
                        
                       
                        
                        
                        print(self.array)
                        if self.array.count > 0
                        {
                            
                            self.activeTable.delegate = self
                            
                           self.activeTable.dataSource = self
                            
                            self.activeTable.reloadData()
                        }
                        else
                        {
                            self.appDelegate.showAlert(titleStr:"No Current Active Services")
                            
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
    
    
    
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
    {
        if self.array != nil
        {
            return self.array.count

        }
        else
        {
            return 0
        }
        
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "activeCellTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! activeCellTableViewCell
        
        let categoryNameStr = (self.array.value(forKey: "category_name") as AnyObject).object(at: indexPath.row) as! NSString
        
        let categoryUserStr = (self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString
       
        let categoryBidStr = (self.array.value(forKey: "bid") as AnyObject).object(at: indexPath.row) as! NSString

        
        
        
//        if categoryNameStr == "Movers" || categoryNameStr  == "Handyman" || categoryNameStr == "Gutters" || categoryNameStr == "Other" || categoryNameStr == "Xmas Lights"
//        {
//            cell.serviceLbl?.text = String(format:"Subervice: %@",((self.array.value(forKey: "category_name") as AnyObject).object(at: indexPath.row) as! NSString))
//
//        }
//        else
//        {
//            cell.serviceLbl?.text = String(format:"Subervice: %@",((self.array.value(forKey: "subcategory_name") as AnyObject).object(at: indexPath.row) as! NSString))
//
//        }
        
        
        cell.serviveNmae.text = categoryNameStr as String
        
        cell.userName.text = categoryUserStr as String

        cell.priceLbl.text = "$" + (categoryBidStr as String) as String
        
        if (categoryNameStr == "Lawncare")
        {
            cell.mainImg?.image = UIImage(named: "Lawncare_1.png")
            
            cell.shortImg?.image = UIImage(named: "Lawncare_1.png")

        }
        else if (categoryNameStr == "Cleaning")
        {
            cell.mainImg?.image = UIImage(named: "Cleaning_1.png")
            
            cell.shortImg?.image = UIImage(named: "Cleaning_1.png")

        }
 
        else if (categoryNameStr == "Pet Service")
        {
            cell.mainImg?.image = UIImage(named: "pet_1.png")
            
            cell.shortImg?.image = UIImage(named: "pet_1.png")


        }
        else if (categoryNameStr == "Pool Service")
        {
            cell.mainImg?.image = UIImage(named: "pool.png")
            
            cell.shortImg?.image = UIImage(named: "pool.png")


        }
        else if (categoryNameStr == "Movers")
        {
            cell.mainImg?.image = UIImage(named: "Mover-2")
            
            cell.shortImg?.image = UIImage(named: "Mover-2")
            
        }
        else if (categoryNameStr == "Handyman")
        {
            cell.mainImg?.image = UIImage(named: "Handyman-1")
            cell.shortImg?.image = UIImage(named: "Handyman-1")

            
            
        }
        else if (categoryNameStr == "Xmas Lights")
        {
            cell.mainImg?.image = UIImage(named: "light.png")
            cell.shortImg?.image = UIImage(named: "light.png")


        }
        else if (categoryNameStr == "Gutters")
        {
            cell.mainImg?.image = UIImage(named: "gutter.png")
            
            cell.shortImg?.image = UIImage(named: "gutter.png")


        }
        else
        {
            cell.mainImg?.image = UIImage(named: "Other_Service-1")
            
            cell.shortImg?.image = UIImage(named: "Other_Service-1")

            
        }
        
    //    cell.bidCountLbl?.text = String(format:"Number of Bid: %@",((self.array.value(forKey: "count_bid") as AnyObject).object(at: indexPath.row) as! NSString))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiveServiceDetailViewController") as! ActiveServiceDetailViewController
        
//        controller.bidId = ((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)
        
        controller.headerStr = headerLbl.text
        controller.serviceId = ((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString) as String!
        controller.recurFeesStr = ((self.array.value(forKey: "Recurfees") as AnyObject).object(at: indexPath.row) as! NSString) as String!
        controller.bidPrice = ((self.array.value(forKey: "bid") as AnyObject).object(at: indexPath.row) as! NSString) as String!
        controller.FinalPrice = ((self.array.value(forKey: "bid") as AnyObject).object(at: indexPath.row) as! NSString) as String!

        self.navigationController!.pushViewController(controller, animated: true)
        
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

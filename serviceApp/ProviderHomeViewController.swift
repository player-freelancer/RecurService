//
//  ProviderHomeViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/21/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class ProviderHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet var btnNotification: UIButton!
    
    @IBOutlet var menu2: DPDropDownMenu!

    @IBOutlet var headerImg: UIImageView!
    
    @IBOutlet var img: UIImageView!
    
    var array: NSMutableArray!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var hud: YBHud!
    
    @IBOutlet var headerLbl: UILabel!
    
    @IBOutlet var homeTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        menu2.isHidden = true
        
        headerImg.isHidden = false
        
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
    
    
    @IBAction func bellTap(_ sender: UIButton)
    {
        let CVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        
        self.navigationController!.pushViewController(CVC, animated: true)

    }
    
    
    @IBAction func menuTap(_ sender: Any)
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
            // [self setupMenuBarButtonItems];
        })
        
    }
    override func didReceiveMemoryWarning()
    {
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
            
            let reqUrl = Base_URL + "GetServices/" + suthTokenStr
            
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
                        var firstArray:NSArray = NSArray()
                        
                        if let resarr = dic.value(forKey: "services") {
                            firstArray = ( resarr as AnyObject) as! NSArray

                        }
                        else  if let resarr = dic.value(forKey: "response") {
                            firstArray = ( resarr as AnyObject) as! NSArray

                        }
                        
                        self.array = firstArray.mutableCopy() as! NSMutableArray
//
                        self.homeTable.delegate = self
                        
                        self.homeTable.dataSource = self
                        
                        self.homeTable.reloadData()
                        
                    //    self.serviceNameArray = (dic.value(forKey: "subcategory_name")as AnyObject) as! NSArray
                    
                    
                    //   let singleArray = (dic.value(forKey: "single_services")as AnyObject) as! NSArray
                    
                    // let countValue = firstArray.count + singleArray.count
                    
                    //  for i in firstArray.count..<firstArray.count + singleArray.count
                    //  {
                    
                    //      self.array .add(singleArray[i-firstArray.count])
                    
                    //    }
                        
                        
                        if self.array.count > 0
                        {
                            
                            self.homeTable.delegate = self
                            
                            self.homeTable.dataSource = self
                            
                            self.homeTable.reloadData()
                        }
                        else
                        {
//                            self.appDelegate.showAlert(titleStr:"No Open Requests in Provider")
                            self.appDelegate.showAlert(titleStr:"No Open Requests")
                            
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
            
            print(myDict)
            
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
        let reuseIdentifier = "ProviderHomeCellTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProviderHomeCellTableViewCell
        
        let categoryNameStr = (self.array.value(forKey: "category_name") as AnyObject).object(at: indexPath.row) as! NSString
        
//        if categoryNameStr == "Movers" || categoryNameStr  == "Handyman" || categoryNameStr == "Gutters" || categoryNameStr == "Other" || categoryNameStr == "Xmas Lights"
//        {
//            cell.serviceLbl?.text = String(format:"Service:%@",((self.array.value(forKey: "category_name") as AnyObject).object(at: indexPath.row) as! NSString))
//
//            cell.daysLbl?.text = String(format:"%@",((self.array.value(forKey: "serviceDate") as AnyObject).object(at: indexPath.row) as! NSString))
//
//        }
//        else
//
//        {
//            let subCatname = ((self.array.value(forKey: "SubcategoryId") as AnyObject).object(at: indexPath.row) as! NSString)
//
//            let fullNameArr = subCatname.components(separatedBy: ",")
//
//            var characters : NSString = "Subservice:"
//
//            for i in 0..<fullNameArr.count
//            {
//                if i == 0
//                {
//                    if fullNameArr[i] == "1"
//                    {
//                        characters = "\(characters)\("Mow")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "2"
//                    {
//                        characters = "\(characters)\("Edge")" as NSString
//
//
//                    }
//                    else if fullNameArr[i] == "3"
//                    {
//                        characters = "\(characters)\("Blow")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "4"
//                    {
//                        characters = "\(characters)\("Bag")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "5"
//                    {
//                        characters = "\(characters)\("Trim Bushes")" as NSString
//
//                    }
//
//                    else if fullNameArr[i] == "6"
//                    {
//                        characters = "\(characters)\("Sweep Floors")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "7"
//                    {
//                        characters = "\(characters)\("Mop Floors")" as NSString
//                    }
//                    else if fullNameArr[i] == "8"
//                    {
//                        characters = "\(characters)\("Windows")" as NSString
//                    }
//                    else if fullNameArr[i] == "9"
//                    {
//                        characters = "\(characters)\("Dust")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "10"
//                    {
//                        characters = "\(characters)\("Bathrooms")" as NSString
//
//
//                    }else if fullNameArr[i] == "11"
//                    {
//                        characters = "\(characters)\("Kitchen")" as NSString
//                    }
//                    else if fullNameArr[i] == "12"
//                    {
//                        characters = "\(characters)\("Walk")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "13"
//                    {
//                        characters = "\(characters) \("Feed")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "14"
//                    {
//                        characters = "\(characters)\("Grooming")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "15"
//                    {
//                        characters = "\(characters)\("Visit/Pay")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "16"
//                    {
//                        characters = "\(characters)\("Clean, Net, Vacuum")" as NSString
//
//                    }
//                    else if fullNameArr[i] == "17"
//                    {
//                        characters = "\(characters)\("Balance Chemicals")" as NSString
//                    }
//                    else if fullNameArr[i] == "18"
//                    {
//                        characters = "\(characters)\("Maintain Equipment")" as NSString
//                    }
//                }
//                else
//                {
//                if fullNameArr[i] == "1"
//                {
//                    characters = "\(characters)\(", Mow")" as NSString
//
//                }
//                else if fullNameArr[i] == "2"
//                {
//                    characters = "\(characters)\(", Edge")" as NSString
//
//
//                }
//                else if fullNameArr[i] == "3"
//                {
//                    characters = "\(characters)\(", Blow")" as NSString
//
//                }
//                else if fullNameArr[i] == "4"
//                {
//                    characters = "\(characters) \(", Bag")" as NSString
//
//                }
//                else if fullNameArr[i] == "5"
//                {
//                    characters = "\(characters)\(", Trim Bushes")" as NSString
//
//                }
//
//                else if fullNameArr[i] == "6"
//                {
//                    characters = "\(characters)\(", Sweep Floors")" as NSString
//
//
//                }
//                else if fullNameArr[i] == "7"
//                {
//                    characters = "\(characters)\(", Mop Floors")" as NSString
//
//                }
//                else if fullNameArr[i] == "8"
//                {
//                    characters = "\(characters)\(", Windows")" as NSString
//
//
//                }
//                else if fullNameArr[i] == "9"
//                {
//                    characters = "\(characters)\(", Dust")" as NSString
//
//                }
//                else if fullNameArr[i] == "10"
//                {
//                    characters = "\(characters)\(", Bathrooms")" as NSString
//
//
//                }else if fullNameArr[i] == "11"
//                {
//                    characters = "\(characters)\(", Kitchen")" as NSString
//
//
//                }
//                else if fullNameArr[i] == "12"
//                {
//                    characters = "\(characters)\(", Walk")" as NSString
//
//                }
//                else if fullNameArr[i] == "13"
//                {
//                    characters = "\(characters)\(", Feed")" as NSString
//
//                }
//                else if fullNameArr[i] == "14"
//                {
//                    characters = "\(characters)\(", Grooming")" as NSString
//
//                }
//                else if fullNameArr[i] == "15"
//                {
//                    characters = "\(characters)\(", Visit/Pay")" as NSString
//
//                }
//                else if fullNameArr[i] == "16"
//                {
//                    characters = "\(characters) \(", Clean, Net, Vacuum")" as NSString
//
//                }
//                else if fullNameArr[i] == "17"
//                {
//                    characters = "\(characters)\(", Balance Chemicals")" as NSString
//
//
//                }
//                else if fullNameArr[i] == "18"
//                {
//                    characters = "\(characters)\(", Maintain Equipment")" as NSString
//
//                }
//
//                }
//            }
        
        let serviecType = (self.array.value(forKey: "Type") as AnyObject).object(at: indexPath.row) as! NSString

        
        cell.serviceLbl?.text = "Service: " + (categoryNameStr as String) as? String
    
        if serviecType == "Single"
        {
            cell.daysLbl?.text = String(format:"%@",((self.array.value(forKey: "serviceDate") as AnyObject).object(at: indexPath.row) as! NSString))

        }
        else
        {
            cell.daysLbl?.text = String(format:"%@",((self.array.value(forKey: "recurrence") as AnyObject).object(at: indexPath.row) as! NSString))

        }

 //       }
        
        
        cell.locationBtn.tag = indexPath.row

        cell.locationBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        cell.nameLBL?.text = String(format:"Customer Name: %@",((self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
        //
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiveServiceDetailViewController") as! ActiveServiceDetailViewController
        
        controller.headerStr = "Service Detail"
        
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        self.navigationController!.pushViewController(controller, animated: true)
        
    }
    @objc func buttonPressed(sender:UIButton)
    {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ShowLocationViewController") as! ShowLocationViewController

        if ((self.array.value(forKey: "address") as AnyObject).object(at: sender.tag) as! NSString) == "single"
        {
            controller.adrressStr = String(format:"%@",((self.array.value(forKey: "user_address") as AnyObject).object(at: sender.tag) as! NSString)) as String!

        }
        else
        {
            controller.adrressStr = String(format:"%@",((self.array.value(forKey: "address") as AnyObject).object(at: sender.tag) as! NSString)) as String!

        }
        
       
        
        controller.latStr = String(format:"%@",((self.array.value(forKey: "lat") as AnyObject).object(at: sender.tag) as! NSString)) as String!
        controller.longStr = String(format:"%@",((self.array.value(forKey: "lng") as AnyObject).object(at: sender.tag) as! NSString)) as String!

        
        self.navigationController!.pushViewController(controller, animated: true)
        
    }
}


    extension ProviderHomeViewController
    {
        fileprivate func setup()
        {
            setupMenu2()
        }
        private func setupMenu2()
        {
            let items = [DPItem(title: "Prvider"),
                         DPItem(title: "Consumer")]
            menu2 = DPDropDownMenu(coder: NSCoder())
            menu2.items = items
         
            
            menu2.headerTitle = "Provider"
            
            menu2.headerTextColor = UIColor(red: 0.0000, green: 0.3529, blue: 0.5569, alpha: 1.0)
            
            menu2.headerBackgroundColor = UIColor.white

            
            menu2.frame = CGRect(x: view.frame.size.width/2 - 76, y: 23, width: 152, height: 35)
            
            view.addSubview(menu2)
            
            var imageView : UIImageView
            
            imageView  = UIImageView(frame:CGRect(x:view.frame.size.width/2 + 45, y:25, width:28, height:30));
            
            imageView.image = UIImage(named:"Dropdown")
                        
            self.view.addSubview(imageView)
            
            menu2.layer.borderWidth = 0.5
                    menu2.layer.borderColor = UIColor.black.cgColor
                    menu2.clipsToBounds = true
            
            
                menu2.didSelectedItemIndex =
                    { index in
                        
                        self.menu2.headerTitle = "Consumer"

                    print("did selected index: \(index)")

        }
       // public var didSelectedItemIndex: ((Int) -> (Void))?

        
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


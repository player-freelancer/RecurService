//
//  UpcomingEventsViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 1/5/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit

class UpcomingEventsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var array: NSMutableArray!

    @IBOutlet var daysTable: UITableView!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    var hud: YBHud!

    var componentArray:NSArray = []
    let dic: NSDictionary = [:]
    
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
            appDelegate.modiFyStr = ""
            
            self.appDelegate.acticeServiceStatus = ""
            
            self.loadServices()

            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backtap(_ sender: UIButton)
    {
        
        self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
            // [self setupMenuBarButtonItems];
        })

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

            let date : Date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let todaysDate = dateFormatter.string(from: date)
            
            print(todaysDate)
            
            let reqUrl = Base_URL + "GetAppointmentsWeekly/" + suthTokenStr + "/" + todaysDate
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    var dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        self.daysTable.isHidden = true

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
                        
                        dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        self.componentArray = dic.allKeys as! NSArray // for NSDictionary

                        print(dic)
                        
                     //   let firstArray:NSArray = dic as! NSArray
                        
                      //  self.array = firstArray.mutableCopy() as! NSMutableArray
                        //
//                        self.daysTable.delegate = self
//
//                        self.daysTable.dataSource = self
//
//                        self.daysTable.reloadData()
                        
                        //    self.serviceNameArray = (dic.value(forKey: "subcategory_name")as AnyObject) as! NSArray
                        
                        
                        //   let singleArray = (dic.value(forKey: "single_services")as AnyObject) as! NSArray
                        
                        // let countValue = firstArray.count + singleArray.count
                        
                        //  for i in firstArray.count..<firstArray.count + singleArray.count
                        //  {
                        
                        //      self.array .add(singleArray[i-firstArray.count])
                        
                        //    }
                        
                        
//                        print(self.array)
//                        if self.array.count > 0
//                        {
//
                            self.daysTable.delegate = self

                            self.daysTable.dataSource = self

                            self.daysTable.reloadData()
//                        }
//                        else
//                        {
//                            self.appDelegate.showAlert(titleStr:"Appoitments not available!")
//
//                        }
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
        return self.componentArray.count
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "upcomingCellTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! upcomingCellTableViewCell
        
        
        cell.dayName?.text = String(format:"%@",self.componentArray.object(at: indexPath.row) as! CVarArg)
        //
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiceServiceViewController") as! ActiceServiceViewController
        
        UserDefaults.standard.set("weekly", forKey: "Comparing")

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

//
//  NotificationViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 1/16/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var array: NSMutableArray!

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var hud: YBHud!

    @IBOutlet var notificationTable: UITableView!
    
    @IBAction func backTap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.getNotifications()
        
       
        // Do any additional setup after loading the view.
    }
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
    {
        return self.array.count
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "NotificationTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! NotificationTableViewCell
        
        
        
        cell.secondLbl?.text = String(format:"%@",((self.array.value(forKey: "message") as AnyObject).object(at: indexPath.row) as! NSString))
        
        


        let dateString = String(format:"%@",((self.array.value(forKey: "date") as AnyObject).object(at: indexPath.row) as! NSString))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let dateFromString: Date? = dateFormatter.date(from: dateString)
        
        let dateFormatter1 = DateFormatter()

        dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        
        let newDate = dateFormatter1.string(from: dateFromString!)
        
        let passDate = dateFormatter1.date(from: newDate)
        
        cell.agoLbl?.text = self.timeSince(from: passDate! as NSDate)
        
        
        
        
        cell.dateLbl?.text = self.dateFormat(from: String(format:"%@",((self.array.value(forKey: "date") as AnyObject).object(at: indexPath.row) as! NSString)) as NSString)
        
        
        
        
        if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "create_service"
        {
            cell.firstLbl.text = "Create Service"
        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "post_bid"
        {
            cell.firstLbl.text = "Post Bid"

        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_service"
        {
            
            cell.firstLbl.text = "Modify Service"

            
        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_request_for_service"
        {
            
            cell.firstLbl.text = "Request for Modify Service"

            
        }
            
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_request_for_singleservice"
        {
            
            cell.firstLbl.text = "Request for Modify Single Service"

            
        }
            
            
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_bid"
        {
            cell.firstLbl.text = "Modify Bid"

            
        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "cancel_bid"
        {
            cell.firstLbl.text = "Cancel Bid"

        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "pause_bid"
        {
            cell.firstLbl.text = "Pause Bid"

        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "finish_service"
        {
            
            cell.firstLbl.text = "Finish Service"

            
        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "accept_bid"
        {
            cell.firstLbl.text = "Accept Bid"

        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "service_renewed"
        {
            cell.firstLbl.text = "Service Renewed"

        }else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "service_paused"
        {
            
            cell.firstLbl.text = "Service Paused"

            
        }
            
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "service_cancelled"
        {
            cell.firstLbl.text = "Service Cancelled"

        }else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "pause_request_for_service"
        {
            
            cell.firstLbl.text = "Request for Pause Service"

            
        }
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "pause_requestbycustomer_for_service"
        {
            
            cell.firstLbl.text = "Request for Pause Service by Customer"

            
        }
            
        else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_request_for_bid"
        {
            
            cell.firstLbl.text = "Request for Modify Bid"

        }
        
        
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
       if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "create_service"
        {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiveServiceDetailViewController") as! ActiveServiceDetailViewController
            
            controller.headerStr = "Service Detail"
            
            controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
            
            self.navigationController!.pushViewController(controller, animated: true)
        }
      else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "post_bid"
        {
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "BidListViewController") as! BidListViewController
            
            controller.bidId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as NSString
            controller.preferredDaysStr = "N/A"
            
            
            self.navigationController!.pushViewController(controller, animated: true)
        }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_service"
       {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
        
        controller.bidId = String(format:"%@",((self.array.value(forKey: "BidId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviveTypeStr = "normal"
        
        controller.serviceNameStr = "modify"
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!

        self.navigationController!.pushViewController(controller, animated: true)
        
       }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_request_for_service"
       {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
        
        controller.bidId = String(format:"%@",((self.array.value(forKey: "BidId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviveTypeStr = "normal"
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!

        controller.serviceNameStr = "modify"
        
        self.navigationController!.pushViewController(controller, animated: true)
        
       }
        
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_request_for_singleservice"
       {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
        
        controller.bidId = String(format:"%@",((self.array.value(forKey: "BidId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!

        controller.serviveTypeStr = "single"
        
        controller.serviceNameStr = "modify"
        
        self.navigationController!.pushViewController(controller, animated: true)
        
       }
        
        
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_bid"
       {
//        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiveServiceDetailViewController") as! ActiveServiceDetailViewController
//
//        controller.headerStr = "Service Detail"
//
//        controller.serviceId = (((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString) as String!)
//
//        self.navigationController!.pushViewController(controller, animated: true)
        
        self.navigationController?.popViewController(animated: true)

       }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "cancel_bid"
       {
        self.navigationController?.popViewController(animated: true)
        
        }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "pause_bid"
       {
        self.navigationController?.popViewController(animated: true)
        
        }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "finish_service"
       {
        
//        if appDelegate.userType == "1"
//        {
        
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
            
            controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
                        
            controller.serviceNameStr = "finish"
            
            self.navigationController!.pushViewController(controller, animated: true)
            
       // }
//        else
//
//        {
//
//        }
        
       }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "accept_bid"
       {
        self.navigationController?.popViewController(animated: true)
        
        }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "service_renewed"
       {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ActiveServiceDetailViewController") as! ActiveServiceDetailViewController
        
        controller.headerStr = "Service Detail"
        
        controller.serviceId = (((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString) as String!)
        
        self.navigationController!.pushViewController(controller, animated: true)
       }else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "service_paused"
       {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
        
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviveTypeStr = "normal"
        
        controller.serviceNameStr = "pause"
        
        self.navigationController!.pushViewController(controller, animated: true)
        
       }
        
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "service_cancelled"
       {
        self.navigationController?.popViewController(animated: true)
        
       }else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "pause_request_for_service"
       {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
        
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviveTypeStr = String(format:"%@",((self.array.value(forKey: "service_info") as AnyObject).object(at: indexPath.row) as! NSString)) as String!

        controller.serviceNameStr = "pause"
        
        self.navigationController!.pushViewController(controller, animated: true)
        
       }
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "pause_requestbycustomer_for_service"
       {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
        
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviveTypeStr = String(format:"%@",((self.array.value(forKey: "service_info") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviceNameStr = "pause"
        
        self.navigationController!.pushViewController(controller, animated: true)
        
       }
        
       else if ((self.array.value(forKey: "type") as AnyObject).object(at: indexPath.row) as! NSString) == "modify_request_for_bid"
       {
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ModifyAcceptViewController") as! ModifyAcceptViewController
                
        controller.serviceId = String(format:"%@",((self.array.value(forKey: "ServiceId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviveTypeStr = String(format:"%@",((self.array.value(forKey: "service_info") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.bidId = String(format:"%@",((self.array.value(forKey: "BidId") as AnyObject).object(at: indexPath.row) as! NSString)) as String!
        
        controller.serviceNameStr = "modify"

        self.navigationController!.pushViewController(controller, animated: true)

        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dateFormat(from: NSString, numericDates: Bool = false) -> String
    {
        //  Converted to Swift 4 by Swiftify v4.1.6600 - https://objectivec2swift.com/
        let myString = from
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let yourDate: Date? = dateFormatter.date(from: myString as String)
        dateFormatter.dateFormat = "dd-MMM"
        
        return dateFormatter.string(from: yourDate!)
    }
    func timeSince(from: NSDate, numericDates: Bool = false) -> String
    {
        
        
        let calendar = Calendar.current
        let now = NSDate()
        let earliest = now.earlierDate(from as Date)
        let latest = earliest == now as Date ? from : now
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        var result = ""
        
        if components.year! >= 2
        {
            result = "\(components.year!) years ago"
        }
        else if components.year! >= 1
        {
            if numericDates {
                result = "1 year ago"
            } else {
                result = "Last year"
            }
        }
        else if components.month! >= 2
        {
            result = "\(components.month!) months ago"
        }
        else if components.month! >= 1
        {
            if numericDates {
                result = "1 month ago"
            } else {
                result = "Last month"
            }
        } else if components.weekOfYear! >= 2 {
            result = "\(components.weekOfYear!) weeks ago"
        } else if components.weekOfYear! >= 1 {
            if numericDates {
                result = "1 week ago"
            } else {
                result = "Last week"
            }
        } else if components.day! >= 2 {
            result = "\(components.day!) days ago"
        } else if components.day! >= 1 {
            if numericDates {
                result = "1 day ago"
            } else {
                result = "Yesterday"
            }
        } else if components.hour! >= 2 {
            result = "\(components.hour!) hours ago"
        } else if components.hour! >= 1 {
            if numericDates {
                result = "1 hour ago"
            } else {
                result = "An hour ago"
            }
        } else if components.minute! >= 2 {
            result = "\(components.minute!) minutes ago"
        } else if components.minute! >= 1 {
            if numericDates {
                result = "1 minute ago"
            } else {
                result = "A minute ago"
            }
        } else if components.second! >= 3 {
            result = "\(components.second!) seconds ago"
        } else {
            result = "Just now"
        }
        
        return result
    }

    
    
    
    func getNotifications()
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
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    print(myDict)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        let str = ((myDict.value(forKey: "response")as AnyObject) as! String)
                        
                        if str == "User! Auth Code Expired"
                        {
                            
                            self.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            self.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        }
                    }
                    else
                    {
                        
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        let firstArray:NSArray = dic as! NSArray
                        
                        self.array = firstArray.mutableCopy() as! NSMutableArray
                        //
                        print(self.array)
                        
                        if self.array.count > 0
                        {
                            
                            self.notificationTable.delegate = self
                            
                            self.notificationTable.dataSource = self
                            
                            self.notificationTable.reloadData()
                        }
                        else
                        {
                            self.showAlert(titleStr:"No Notification Found")
                            
                        }
                    }
                    //    let dic = (myDict.value(forKey: "response")as AnyObject) as! NSDictionary
                    
                    
                    
            })
        }
        else
        {
            self.showAlert(titleStr: "Please check your internet connection.")
            
        }
    }
    func showAlert(titleStr:String)
    {
        let alert = UIAlertController(title: "Alert", message: titleStr, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func finishService(serviceId:NSString)
    {
    
    if (appDelegate.networkCheck() == true)
    {
    hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
    hud.dimAmount = 0.7
    hud.show(in: view, animated: true)
    
    let parametersDicto : NSMutableDictionary? = [:]
    
    let suthTokenStr = appDelegate.authToken! as String
    
        let reqUrl = Base_URL + "customerreject4service/" + suthTokenStr + "/" + (serviceId as String)
    
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
              self.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
            }
            else
            {
              self.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
            }
            }
            else
            {
                self.navigationController?.popViewController(animated: true)
                
                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))

            }
                
    })
    }
    else
    {
    self.showAlert(titleStr: "Please check your internet connection.")
    
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

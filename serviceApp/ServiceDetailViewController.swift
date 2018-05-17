//
//  ServiceDetailViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/26/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class ServiceDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var categoryId, subCatId, addressStr, yardStr, notesStr, recuurenceStr, preferredDays, dayStr, dayss, floorCount: String!
    
    @IBOutlet var titleLbl: UILabel!

    var daysCount: Int!
    
    var hud: YBHud!

    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var serviceTable: UITableView!

    var strSizeType = "Square Feet"
    
    @IBAction func submitTap(_ sender: UIButton)
    {
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            
            hud.show(in: view, animated: true)
            let fullNameArr : [String]
            if appDelegate.otherValue == "Others"
            {
                fullNameArr = appDelegate.otherValue!.components(separatedBy: "Others")
            
            }
            else
            {
              fullNameArr = appDelegate.otherValue!.components(separatedBy: "Others,")

            }
            var parametersDicto : NSMutableDictionary?

            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            var reqUrl = ""
            
            if floorCount == ""
            {
                floorCount = "dummy"
            }
            
            if appDelegate.serviceType == "simpleService"
            {
               if appDelegate.modiFyStr == "modiFy"
                {
                    reqUrl = Base_URL + "ModifyServicebycustomer"
                    
                    if fullNameArr.count == 1
                    {
                        parametersDicto =  ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[0],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"ServiceId":appDelegate.selectedServiceId,"floor_name":"dummy"]

                    }
                    else
                    {
                        parametersDicto =  ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[1],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"ServiceId":appDelegate.selectedServiceId,"floor_name":"dummy"]

                    }
                }
                
                else
                {
                    reqUrl = Base_URL + "SaveService"
                    
                    if fullNameArr.count == 1
                    {
                        parametersDicto =  ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[0],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"floor_name":"dummy"]

                    }
                    else
                    {
                        parametersDicto =  ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[1],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"floor_name":floorCount]
                    }
                }
            }
            else if appDelegate.serviceType == "PUSH PROVIDER PROFILE"
            {
                 reqUrl = Base_URL + "PushProviderService"
                
                if fullNameArr.count == 1
                {
                    parametersDicto = ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[0],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"private_provider" : appDelegate.custoProviderId,"floor_name":"dummy"]

                }
                else
                {
                parametersDicto = ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[1],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"private_provider" : appDelegate.custoProviderId,"floor_name":"dummy"]
                }

            }
            else
            {
                reqUrl = Base_URL + "PushProviderService"
                
                if fullNameArr.count == 1
                {
                    parametersDicto = ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[0],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"private_provider" : appDelegate.custoProviderId,"floor_name":"dummy"]
                    
                }
                else
                {
                    parametersDicto = ["auth_code":appDelegate.authToken,"CategoryId":categoryId,"SubcategoryId":subCatId,"other_val":fullNameArr[1],"address":addressStr,"yard_size":yardStr,"notes":notesStr,"recurrence":recuurenceStr,"preferredDays":dayStr,"private_provider" : appDelegate.custoProviderId,"floor_name":"dummy"]
                }
                
            }
            print(parametersDicto!)

            Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
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
                        self.appDelegate.selectAddressStr = ""

                        if self.appDelegate.serviceType == "simpleService"
                        {
                            if self.appDelegate.modiFyStr == "modiFy"
                            {
                                
                                self.appDelegate.acticeServiceStatus = "active"

                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                                
                                for aViewController in viewControllers
                                {
                                    if(aViewController is ActiceServiceViewController)
                                    {
                                        self.navigationController!.popToViewController(aViewController, animated: true);
                                    }
                                }
                            }
                            else
                            
                            {
                            
                            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                            
                            for aViewController in viewControllers
                            {
                                if(aViewController is HomeViewController)
                                {
                                    self.navigationController!.popToViewController(aViewController, animated: true);
                                }
                            }
                            }
                        }
                        else
                        {
                            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                            
                            for aViewController in viewControllers
                            {
                                if(aViewController is SingleServiceViewController)
                                {
                                    self.navigationController!.popToViewController(aViewController, animated: true);
                                }
                            }
                            
                        }
                        
                        if self.appDelegate.modiFyStr == "modiFy"
                        {
                            self.appDelegate.modiFyStr = ""

                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))

                        }
                        else
                            
                        {
                        
                        self.appDelegate.showAlert(titleStr: "Service Request Submitted")
                        }
                        
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
        serviceTable.delegate = self
        serviceTable.dataSource = self
        titleLbl.text = appDelegate.serviceName as String?
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int
    {
        return 5
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "ServiceDetailTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ServiceDetailTableViewCell
        
        if indexPath.row == 0
        {
            cell.serviecNameLbl.text = "Summary"
            
            
            let str = appDelegate.subCatName! as String
            
            let fullNameArr : [String] = appDelegate.otherValue!.components(separatedBy: "Others,")
            
            if fullNameArr.count > 1
            {
                let serviceNameStr = "\(str),\(fullNameArr[1])"
                cell.serviceDescLbl?.text = serviceNameStr as String

            }
            else
            
            {
                let serviceNameStr = str
                
                cell.serviceDescLbl?.text = serviceNameStr as String


            }
            

        }
        else if indexPath.row == 1
        {
            
            if titleLbl.text == "Pet Service"
            {
                cell.serviecNameLbl.text = "Pets"
                
                cell.serviceDescLbl.text = yardStr

                
            }
            else if titleLbl.text == "Lawncare"
            {
                cell.serviecNameLbl.text = "Approximate Size"
                
                yardStr = yardStr + " \(strSizeType)"
                
                cell.serviceDescLbl.text = yardStr
            }
            else  if titleLbl.text == "Pool Service"
            {
                cell.serviecNameLbl.text = "Pool Size"
                
                cell.serviceDescLbl.text = yardStr

            }
            else
            {
                cell.serviecNameLbl.text = "Approximate size"
                
                cell.serviceDescLbl.text = yardStr + ", Floor:" + floorCount
            }
        }
        else if indexPath.row == 2
        {
            cell.serviecNameLbl.text = "Address"

            cell.serviceDescLbl.text = addressStr

        }
        else if indexPath.row == 3
        {
            cell.serviecNameLbl.text = "Recurrence"
            
            cell.serviceDescLbl.text = recuurenceStr
        }
        else if indexPath.row == 4
        {
            cell.serviecNameLbl.text = "Days"
            
            cell.serviceDescLbl.text = dayStr
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        selectedIndexPath = indexPath
        
        
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

//
//  SelectServiceViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/26/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class SelectServiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    @IBOutlet var titleLbl: UILabel!

    var hud: YBHud!
    
    var otherArray : NSMutableArray = ["Others"]

    var checkaArray: NSMutableArray = []

    var subCatArray: NSMutableArray = []

    var subcatArrayName: NSMutableArray = []

    var array: NSArray = []

    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    var categoryId, subCatID: String!

    @IBOutlet var selectServiceBtn: UIButton!
    
    @IBAction func     selectServiceTap(_ sender: UIButton)
    {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "SelectAddressViewController") as! SelectAddressViewController
        //        //
        
        let joinedComponents: String = (subCatArray as NSArray).componentsJoined(by: ",")
        
        controller.subCatId = joinedComponents

        appDelegate.subCatName = (subcatArrayName as NSArray).componentsJoined(by: ", ")
            as NSString
        
        controller.categoryId = categoryId
        
        appDelegate.otherValue = (otherArray as NSArray).componentsJoined(by: ", ")
            as NSString
        
        self.navigationController!.pushViewController(controller, animated: true)

    }
    @IBOutlet var serviceTable: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.getLoadCategories()
        
       
        
        selectServiceBtn.isEnabled = false
        
        selectServiceBtn.isUserInteractionEnabled = false
        
        titleLbl.text = appDelegate.serviceName as! String
        
        // Do any additional setup after loading the view.
    }

    @IBAction func backtap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getLoadCategories()
        
    {
        
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            let reqUrl = Base_URL + "GetSubCategoryList/" + categoryId
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                                   completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    let dic = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                        
                    }
                    else
                    {
                    
                    
                    self.array = dic as! NSArray
                    
                    print(self.array)
                    
                    for index in 0..<self.array.count+1

                    {
                        self.checkaArray.add("N")
                    }
                        
                        
                    self.serviceTable.delegate = self
                    
                        
                        
                    self.serviceTable.dataSource = self
                    
                    self.serviceTable.reloadData()
                    
                    //    let dic = (myDict.value(forKey: "response")as AnyObject) as! NSDictionary
                    
                    }
                    
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
        
        
        let countValue = array.count + otherArray.count
        
        return countValue
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "SelectServiceTableViewCell"
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SelectServiceTableViewCell
        
        if indexPath.row < array.count
        {
            
            if (checkaArray.object(at: indexPath.item) as! NSString) == "Y"
            {
                cell.checkImg?.image = UIImage(named: "Checked icon.png")
                
            }
            else
            {
                cell.checkImg?.image = UIImage(named: "Uncheck.png")
                
            }
            cell.serviceLbl.text = String(format:"%@",((array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
        }
        else
        {
            
            if (checkaArray.object(at: indexPath.item) as! NSString) == "Y"
            {
                cell.checkImg?.image = UIImage(named: "Checked icon.png")
                
            }
            else
            {
                cell.checkImg?.image = UIImage(named: "Uncheck.png")
                
            }
            cell.serviceLbl.text = String(format:"%@",otherArray[indexPath.row - self.array.count] as! NSString)
        }
      //  cell.serviceImg?.image = UIImage(named: logoImages[indexPath.row])
       
        tableView.rowHeight = 60
        //
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row < array.count
        {
        
        
        for index in 0..<array.count

        {
            if index == indexPath.row
                {
                
                if (checkaArray.object(at: index) as! NSString) == "Y"
                {
                    self.checkaArray.replaceObject(at: index, with: "N")
                    
                    subCatID = String(format:"%@",((array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString))

                   let subCatname = String(format:"%@",((array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
                    
                    subcatArrayName .remove(subCatname)
                    
                    subCatArray .remove(subCatID)
                    
                }
                else
                {
                    self.checkaArray.replaceObject(at: index, with: "Y")
                    
                    subCatID = String(format:"%@",((array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString))
                    
                    subCatArray .add(subCatID)
                    
                    let subCatname = String(format:"%@",((array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
                    
                    
                    
                    subcatArrayName .add(subCatname)


                  }
                }
            
            if subCatArray.count > 0

            {
                selectServiceBtn.isEnabled = true
                
                selectServiceBtn.isUserInteractionEnabled = true

                
            }
            else
            
            {
                selectServiceBtn.isEnabled = false

                selectServiceBtn.isUserInteractionEnabled = false

            }
            
            
            serviceTable.reloadData()
           
            }
        }
        else
        {
            if (otherArray.count < 6)
            {
            
            if indexPath.row == array.count
            {
                var alert = UIAlertController(title: nil, message: "Create your service", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Service Name"
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
                        
                        
                        
                        let str : NSString = textField.text! as NSString
                        
                        if (str.length == 0)
                        {
                            
                        }
                        else
                        {
                            
                            self.otherArray.add(str)
                            
                    
                            
                            self.checkaArray.add("Y")
                            
//                            if self.checkaArray.count > 0
//                                
//                            {
//                                self.selectServiceBtn.isEnabled = true
//                                
//                                self.selectServiceBtn.isUserInteractionEnabled = true
//                                
//                                
//                            }
//                            else
//                                
//                            {
//                                self.selectServiceBtn.isEnabled = false
//                                
//                                self.selectServiceBtn.isUserInteractionEnabled = false
//                                
//                            }

                            
                            self.serviceTable.reloadData()
                            
                            
                            
                            print("User click Ok button")
                        }
                        
                        
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
                        
                        
                    }))
                    
                    
                    self.present(alert, animated: true, completion: {
                        print("completion block")
                    })
                    
                }
            }
        else
            {
                
            }
            }
            else
            {
                appDelegate.showAlert(titleStr: "You can not create more service!")
            }
            
      
      

    }

}
}

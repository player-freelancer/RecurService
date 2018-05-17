//
//  BidListViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/10/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class BidListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var bidId,preferredDaysStr : NSString!

    @IBAction func backTap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)

    }
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud: YBHud!
    var array: NSArray = []

    @IBOutlet var bidTable: UITableView!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.getLoadBids()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getLoadBids()
        
    {
        
        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            //   {{base_url}}/GetBids/{service_id}/{limit}/{offset}
              let bid = bidId! as String
            
            let reqUrl = Base_URL + "GetBids/" +  bid + "/10" + "/0"
            
            Webhelper.requestGETservice (reqUrl as String,parameters: parametersDicto!,
                                         completionHandler:
                {
                    (myDict,error) in
                    
                    self.hud .dismiss(animated: true)
                    
                    _ = (myDict.value(forKey: "response")as AnyObject)
                    
                    if (myDict.value(forKey: "code") as! NSInteger) == 201
                    {
                        self.appDelegate.showAlert(titleStr: "No Bids for this Service")
                        
                    }
                    else
                    {
                        print(myDict)

                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        self.array = dic as! NSArray
                        
                        print(self.array)
                        
        
                        self.bidTable.delegate = self
                        
                        self.bidTable.dataSource = self
                        
                        self.bidTable.reloadData()
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
        return self.array.count
        
        //        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let reuseIdentifier = "BidTableViewCell"
        
        print(self.array[0])
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! BidTableViewCell
        
     //   cell.serviceLbl?.text = String(format:"Subervice: %@",((self.array.value(forKey: "SubcategoryId") as AnyObject).object(at: indexPath.row) as! NSString))
        
        
    //
       
        let dict = self.array[0] as! [String: AnyObject]
        cell.nameLbl?.text = String(format:"Provider: %@",dict["name"] as! String)
        
        
        cell.bidCountLbl?.text = String(format:"Bid Rate: $%@",dict["bid"] as! String)
//        cell.bidCountLbl?.text = String(format:"Bid Rate: $%@",dict["Finalcollected"] as! String)

        if let rating = dict["rating"] as? String {
            
            let myBitRating: Int = Int(rating)!
            
            for i in 0..<myBitRating {
                
                let imgView = cell.viewWithTag(1001+i) as! UIImageView
                
                imgView.image = UIImage(named: "Rating_Black")
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        selectedIndexPath = indexPath
        
        //
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "BidDetailViewController") as! BidDetailViewController
        
        controller.bidId = ((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString)
        controller.bidStr = ((self.array.value(forKey: "bid") as AnyObject).object(at: indexPath.row) as! NSString)
//        controller.bidStr = ((self.array.value(forKey: "Finalcollected") as AnyObject).object(at: indexPath.row) as! NSString)
        controller.nameStr = ((self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString)
        controller.notesStr = ((self.array.value(forKey: "notes") as AnyObject).object(at: indexPath.row) as! NSString)
        controller.rating = ((self.array.value(forKey: "rating") as AnyObject).object(at: indexPath.row) as! NSString)
        controller.preferredDaysStr = ((self.array.value(forKey: "preferredDays") as AnyObject).object(at: indexPath.row) as! NSString)


        //
        //        controller.imagePath = person.value(forKeyPath: "watchUrl") as? NSString as String?
        //
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

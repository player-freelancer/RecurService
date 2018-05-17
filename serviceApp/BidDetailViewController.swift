//
//  BidDetailViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/26/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit

class BidDetailViewController: UIViewController
{
    @IBOutlet var headerlbl: UILabel!
    
    @IBOutlet var notesHeaderLbl: UILabel!
    var bidId, notesStr, nameStr, dayStr, bidStr, rating, preferredDaysStr : NSString!
    
    @IBOutlet var viewRating: UIView!
    @IBOutlet var img1: UIImageView!
    @IBOutlet var img2: UIImageView!
    @IBOutlet var img3: UIImageView!
    @IBOutlet var img4: UIImageView!
    @IBOutlet var img5: UIImageView!

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var hud: YBHud!

    @IBOutlet var notesTV: UITextView!
    @IBOutlet var bidLbl: UILabel!
    
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet var notesLbl: UITextView!
    @IBOutlet var dayLbl: UILabel!
   
    @IBOutlet var notesView: UIView!
    
    @IBAction func backToNotes(_ sender: UIButton)
    {
        notesView.isHidden = true
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        nameLbl.text = nameStr as? String
        bidLbl.text = bidStr as? String
        notesLbl.text = notesStr! as String
        dayLbl.text = preferredDaysStr as! String//nameStr as! String

        if let getRating = rating as? String {
            
            let myBitRating: Int = Int(getRating)!
            
            for i in 0..<myBitRating {
                
                let imgView = viewRating.viewWithTag(1001+i) as! UIImageView
                
                imgView.image = UIImage(named: "RatingW")
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backTap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func accepTap(_ sender: UIButton)
    {
        notesView.isHidden = false
    }
    @IBAction func submitBtn(_ sender: UIButton)
        {
            if (appDelegate.networkCheck() == true)
            {

            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7

            hud.show(in: view, animated: true)

                let suthTokenStr = appDelegate.authToken! as String

            let parametersDicto : NSMutableDictionary? = ["bid_id":bidId,"notes":notesTV.text,"auth_code":suthTokenStr,"status":"1"]

            //  URL: http://dewseekers.com/demo/recur/userapi.php

            let reqUrl = Base_URL + "AcceptBid?"

            Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
            completionHandler:
            {
            (myDict,error) in

            print(myDict)


            self.hud .dismiss(animated: true)


            print(myDict.value(forKey: "code") as! NSInteger)

            if (myDict.value(forKey: "code") as! NSInteger) == 201
            {
            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
            }
            else
            {
                self.appDelegate.acticeServiceStatus = "active"
                
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as! [UIViewController];
                
                for aViewController in viewControllers
                {
                    if(aViewController is CustDashboardViewController){
                        self.navigationController!.popToViewController(aViewController, animated: true);
                    }
                }
                
                self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                
            }


            })
            }
            else
            {
                appDelegate.showAlert(titleStr: "Please check your internet connection.")

            }
        
    ///////////////////// Tab Bar
    
    
    }
    /*
    // MARK: - Navigation

     @IBAction func submitTap(_ sender: UIButton) {
     }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

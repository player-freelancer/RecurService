//
//  HomeViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 11/9/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit
import MessageUI
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,MFMailComposeViewControllerDelegate
{
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    var hud: YBHud!

    var selectService:NSString!
    
    @IBOutlet var menuBtn: UIButton!
    var files = ["Lawncare", "Cleaning","Pet","Pool","Xmas Lights","Gutters"]
    
    var array: NSArray = []
    
    var logoImage: [String] = [
        "Lawncare_1.png",
        "Cleaning_1.png",
        "pet_1.png",
        "pool.png",
        "Mover-2",
        "Handyman-1",
        "light.png",
        "gutter.png",
        "Other_Service-1"
    ]
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    @IBOutlet var homeLayout: UICollectionViewFlowLayout!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return array.count + 1;
    }
    
    @IBAction func menutap(_ sender: UIButton)
    {
        if appDelegate.modiFyStr == "modiFy"
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let reuseIdentifier = "GridCollectionViewCell"
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! GridCollectionViewCell
        
        if (indexPath.row == array.count)
        {
            cell.serviceLbl.text = "Suggest New Service"

        }
        else
        
        {
            cell.serviceLbl.text = String(format:"%@",((self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
            
            cell.serviceImg?.image = UIImage(named: logoImage[indexPath.row])
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {

    //
        if selectService == "2"
            
        {
            
            if (appDelegate.networkCheck() == true)
            {
                
                hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
                hud.dimAmount = 0.7
                
                hud.show(in: view, animated: true)
                
                let serviecName = String(format:"%@",((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString))

                let parametersDicto : NSMutableDictionary? = ["auth_code":appDelegate.authToken,"contact_no":"","password":"","miles":"100","service":serviecName,"address":"","type":appDelegate.userType,"name":""]
                
                //  URL: http://dewseekers.com/demo/recur/userapi.php
                
                let reqUrl = Base_URL + "UpdateProfile?"
                
                Webhelper.requestFisheFieldWithHandler(reqUrl as String,parameters: parametersDicto!,
                                                       completionHandler:
                    {
                        (myDict,error) in
                        
                        print(myDict)
                        
                        self.hud .dismiss(animated: true)
                        
                        let dic = (myDict.value(forKey: "response")as   AnyObject) as! NSDictionary
                        
                        if (myDict.value(forKey: "code") as! NSInteger) == 201
                        {
                            self.appDelegate.showAlert(titleStr: ((myDict.value(forKey: "response")as AnyObject) as! String))
                            
                        }
                        else
                        {
                            UserDefaults.standard.set(serviecName, forKey: "service")

                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let TSUVC = storyboard.instantiateViewController(withIdentifier: "ProviderHomeViewController")
                            let navController = UINavigationController(rootViewController: TSUVC)
                            navController.navigationBar.backgroundColor = UIColor.blue
                            let leftMenuViewController = SideMenuViewController()
                            leftMenuViewController .strF = self.appDelegate.userName! as String;
                            
                            let container = MFSideMenuContainerViewController.container(withCenter: navController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
                            navController.navigationBar.isHidden = true
                            self.appDelegate.window!.rootViewController! = container!
                        }
                })
            }
            else
            {
                appDelegate.showAlert(titleStr: "Please check your internet connection.")
                
            }
        }
        
        else
            
        {
            if (indexPath.row == array.count)
            {
                self.sendEmailButtonTapped()
            }
            else
            
            {
                let serviecType = String(format:"%@",((self.array.value(forKey: "ServiceType") as AnyObject).object(at: indexPath.row) as! NSString))
                
                if serviecType == "1"
                {
                    let controller = self.storyboard!.instantiateViewController(withIdentifier: "SelectServiceViewController") as! SelectServiceViewController
                    
                    let serviceName = String(format:"%@",((self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
                    
                    controller.categoryId = String(format:"%@",((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString))
                    
                    appDelegate.serviceName = serviceName as NSString
                    
                    //
                    //
                    self.navigationController!.pushViewController(controller, animated: true)
                    
                }
                else
                    
                {
                    let serviceName = String(format:"%@",((self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
                    
                    if serviceName == "Movers" || serviceName == "Gutters"
                        
                    {
                        
                        let controller = self.storyboard!.instantiateViewController(withIdentifier: "SelectSingleViewController") as! SelectSingleViewController
                        
                        
                        controller.categoryId = String(format:"%@",((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString))
                        
                        
                        appDelegate.serviceName = serviceName as NSString
                        
                        //
                        //
                        self.navigationController!.pushViewController(controller, animated: true)
                    }
                        
                    else
                    {
                        
                        let controller = self.storyboard!.instantiateViewController(withIdentifier: "NotMoversViewController") as! NotMoversViewController
                        
                        
                        controller.categoryId = String(format:"%@",((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString))
                        
                        
                        appDelegate.serviceName = serviceName as NSString
                        
                        //
                        //
                        self.navigationController!.pushViewController(controller, animated: true)
                        
                    }
                }
           }
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        appDelegate.serviceType = "simpleService"
        

        if selectService == "2"
            {
              menuBtn.isHidden = true
            }
        else
        {
            if appDelegate.modiFyStr == "modiFy"
            {
                menuBtn.setImage(UIImage(named: "Back"), for: .normal)
            }
            else            
            {
                menuBtn.setImage(UIImage(named: "Menu"), for: .normal)
            }

        }
        self.getLoadCategories()

        // Do any additional seretup after loading the view.
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
            
            let reqUrl = Base_URL + "GetCategoryList"
            
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
                        let dic = (myDict.value(forKey: "response")as AnyObject)
                        
                        self.array = dic as! NSArray
                        
                        print(self.array)
                        
                        self.homeLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    
                        if self.view.frame.size.width == 320
                        {
                            self.homeLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                            self.homeLayout.itemSize = CGSize(width: 130, height: 130)
                        }
                        else
                        {
                            self.homeLayout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 10, right: 30)
                            self.homeLayout.itemSize = CGSize(width: 140, height: 140)
                        }
                        
                        
                        self.homeLayout.minimumInteritemSpacing = 0
                        
                        self.homeLayout.minimumLineSpacing = 0
                        
                        self.homeCollectionView.collectionViewLayout = self.homeLayout
                        
                        self.homeCollectionView.delegate = self
                        
                        self.homeCollectionView.dataSource = self
                        
                        self.homeCollectionView.reloadData()
                        //    let dic = (myDict.value(forKey: "response")as AnyObject) as! NSDictionary
                    }
                    
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")

        }
    }
    
    
     func sendEmailButtonTapped()
     {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["admin@recur.com"])
        mailComposerVC.setSubject("Recur:Suggest New Service")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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

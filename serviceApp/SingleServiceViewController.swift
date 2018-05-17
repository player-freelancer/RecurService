//
//  SingleServiceViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 12/7/17.
//  Copyright © 2017 Gourav sharma. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SingleServiceViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITextFieldDelegate
{
    @IBOutlet var emailView: UIView!
    @IBOutlet var tittleLbl: UILabel!
    @IBOutlet var emailTF: UITextField!
    
    var seletionInt:Int = 0;
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var hud: YBHud!

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
        return array.count;
    }
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
       
        
        emailTF.resignFirstResponder()
        
        if emailTF.text != ""
        {
            print("Hum! Here")

            let emailBool:Bool = appDelegate.isValidEmail(testStr: emailTF.text!)

            if (emailBool == false)
            {
                appDelegate.showAlert(titleStr: "Please enter valid email address")

            }

            else

            {
                self.emailExistService()

            }

        }
        else
        {

        }
        return true
    }
    
     func emailExistService()
     {

        if (appDelegate.networkCheck() == true)
        {
            hud = YBHud(hudType: DGActivityIndicatorAnimationType(rawValue: 17)!)
            hud.dimAmount = 0.7
            hud.show(in: view, animated: true)
            
            let parametersDicto : NSMutableDictionary? = [:]
            
            //  URL: http://dewseekers.com/demo/recur/userapi.php
            
            var reqUrl = ""

           if  tittleLbl.text == "PUSH CUSTOMER PROFILE"
            {
              reqUrl = Base_URL + "checkemailexists/" + emailTF.text!
            }
            else
            {
               reqUrl = Base_URL + "checkprovideremailexists/" + emailTF.text!
            }
            
            
            
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
                        
                        
                        self.emailTF.resignFirstResponder()
                        
                        self.seletionInt = 1
                        
                        self.appDelegate.custoProviderId = dic as? NSString
                        
                        self.appDelegate.showAlert(titleStr: "Email verfied successfully")

                        //    let dic = (myDict.value(forKey: "response")as AnyObject) as! NSDictionary
                        
                    }
            })
        }
        else
        {
            appDelegate.showAlert(titleStr: "Please check your internet connection.")
            
        }
    }
    
    @IBAction func backTap(_ sender: UIButton)
    {
        self.menuContainerViewController.toggleLeftSideMenuCompletion({() -> Void in
            // [self setupMenuBarButtonItems];
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let reuseIdentifier = "GridCollectionViewCell"
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! GridCollectionViewCell
    
            
        
            cell.serviceLbl.text = String(format:"%@",((self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
            
            cell.serviceImg?.image = UIImage(named: logoImage[indexPath.row])
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //
       if  seletionInt == 1
       {
        
        let serviecType = String(format:"%@",((self.array.value(forKey: "ServiceType") as AnyObject).object(at: indexPath.row) as! NSString))
        
        if serviecType == "1"
        {
            
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "SelectServiceViewController") as! SelectServiceViewController
            
            let serviceName = String(format:"%@",((self.array.value(forKey: "name") as AnyObject).object(at: indexPath.row) as! NSString))
            
            controller.categoryId = String(format:"%@",((self.array.value(forKey: "id") as AnyObject).object(at: indexPath.row) as! NSString))
            
            appDelegate.serviceName = serviceName as NSString

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
        else
       {
        

        }
    }
    func viewDidAppear()
    {
        self.emailTF.text = nil

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       emailTF.delegate = self

        emailView.layer.borderWidth = 1
        emailView.layer.cornerRadius = 5
        emailView.layer.borderColor = UIColor.white.cgColor
        emailView.clipsToBounds = true
        
        let color: UIColor? = UIColor.white
        
       
            emailTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: color ?? "", NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        if UserDefaults.standard.string(forKey: "Comparing") == "customer"
        {
            
            appDelegate.serviceType = "PUSH CUSTOMER PROFILE"

            tittleLbl.text = "PUSH CUSTOMER PROFILE"
            
        }
        else
            
        {
            appDelegate.serviceType = "PUSH PROVIDER PROFILE"

            tittleLbl.text = "PUSH PROVIDER PROFILE"
        }
        
//        emailTF.text = "gourav.sha13@gmail.com"
        
        self.getLoadCategories()
        
        // Do any additional seretup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

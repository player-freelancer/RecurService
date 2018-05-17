///
//  WebHelperSwift.swift
//  SwiftiFy
//
//  Created by Nitin on 23/08/17.
//  Copyright © 2017 Nitin. All rights reserved.
//

import Foundation
import AFNetworking
var responseDict = NSDictionary()

//protocol Webhelper
//{
//}


class Webhelper: NSObject
{
    
    
    class func sharedHelper() -> Webhelper
    {
        var sharedInstance: Webhelper? = nil
        if sharedInstance == nil
        {
            sharedInstance = Webhelper()
        }
        return sharedInstance!
    }

    
//     func callWebservice(parameters:NSDictionary,controler:HomeViewController)
//    {
//        // let url = NSURL(string:  + "/" + String(300))
//        
////        let parameters : NSMutableDictionary? = [
////            
////            "user_name": "123@gmail.com",
////            "password": "82810"]
//        
//        let manager = AFHTTPSessionManager()
//        
//        let serializerRequest = AFJSONRequestSerializer()
//        
//        serializerRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        
//        manager.requestSerializer = serializerRequest
//        
//        let serializerResponse = AFJSONResponseSerializer()
//        
//        serializerResponse.readingOptions = JSONSerialization.ReadingOptions.allowFragments
//        serializerResponse.acceptableContentTypes = ((((NSSet(object: "text/json") as! Set<String>) as Set<String>) as Set<String>) as Set<String>) as Set<String>;
//        
//        manager.responseSerializer = serializerResponse
//        manager.post("http://webmobsoftware.com/event/index.php/mobile/staff_login?", parameters: parameters, progress: nil, success:
//            {
//                (task: URLSessionDataTask, responseObject: Any?) in
//            if (responseObject as? [String: AnyObject]) != nil
//            {
//                responseDict = responseObject as! NSDictionary
//                
//                print("responseObject \(responseDict)")
//                
//             //   controler.response(responseDict: responseDict)
//            }
//        })
//        {
//            (task: URLSessionDataTask?, error: Error) in
//            
//           // responseDict = responseObject as! NSDictionary
//
//         //   controler.Erorr(error: error as NSError)
//            
//            print("POST fails with error \(error)")
//        }
//    }
    
    static  func requestFisheFieldWithHandler(_ url:String,parameters:NSDictionary, completionHandler: @escaping (_ results:NSDictionary, NSError?) -> Void)
        {
            let manager = AFHTTPSessionManager()
                        
//            manager.requestSerializer.setValue("multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW", forHTTPHeaderField: "Content-Type")
            
//            "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW"
            
//            manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["json"]) as? Set<String>
            
          //  let str = "c5ea245f-e67f-4e03-9ee0-d18529ff4d08"
            
          //  manager.requestSerializer.setValue(str, forHTTPHeaderField: "user-agent")
            
            manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json"]) as? Set<String>
            
            
            manager.post(url, parameters: parameters, progress: nil, success:
                {
                    (task: URLSessionDataTask, responseObject: Any?) in
                    if (responseObject as? [String: AnyObject]) != nil
                    {
                        responseDict = responseObject as! NSDictionary
                        
                        print("responseObject \(responseDict)")
                        
                        
                        completionHandler(responseDict,nil)
                        
                      //  controler.response(responseDict: responseDict)
                    }
                    else
                    
                    {
                        print("empty")
                    }
            })
            {
                (task: URLSessionDataTask?, error: Error) in
                
                // responseDict = responseObject as! NSDictionary
                responseDict = [:]
                completionHandler(responseDict,error as NSError?)
                
                print("POST fails with error \(error.localizedDescription)")
            }
        }
    
    static  func requestGETservice(_ url:String,parameters:NSDictionary, completionHandler: @escaping (_ results:NSDictionary, NSError?) -> Void)
    {
        let manager = AFHTTPSessionManager()
        
        // serializerRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["json"]) as? Set<String>
        
        //  let str = "c5ea245f-e67f-4e03-9ee0-d18529ff4d08"
        
        //  manager.requestSerializer.setValue(str, forHTTPHeaderField: "user-agent")
        
        manager.responseSerializer.acceptableContentTypes = Set<AnyHashable>(["application/json", "text/json", "text/javascript", "text/html"]) as? Set<String>
        
        
        manager.get(url, parameters: parameters, progress: nil, success:
            {
                (task: URLSessionDataTask, responseObject: Any?) in
                if (responseObject as? [String: AnyObject]) != nil
                {
                    responseDict = responseObject as! NSDictionary
                    
                    print("responseObject \(responseDict)")
                    
                    
                    completionHandler(responseDict,nil)
                    
                    //  controler.response(responseDict: responseDict)
                }
                else
                    
                {
                    print("empty")
                }
        })
        {
            (task: URLSessionDataTask?, error: Error) in
            
            // responseDict = responseObject as! NSDictionary
            
            completionHandler(responseDict,error as NSError?)
            
            print("POST fails with error \(error.localizedDescription)")
        }
    }
    
}

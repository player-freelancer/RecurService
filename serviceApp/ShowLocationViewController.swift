//
//  ShowLocationViewController.swift
//  serviceApp
//
//  Created by Gourav sharma on 1/3/18.
//  Copyright © 2018 Gourav sharma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ShowLocationViewController: UIViewController,MKMapViewDelegate
{
    let newPin = MKPointAnnotation()

    @IBOutlet var mapView: MKMapView!
    
    var locationManager = CLLocationManager.init()
    
    var adrressStr, latStr, longStr : String!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        
        let finalLat = latStr as String
        
        let lattitude = Double(finalLat)
        
        let finalLong = longStr as String
        
        let longitude = Double(finalLong)
        
        let location = CLLocation(latitude: lattitude!, longitude: longitude!)

        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        //set region on the map
        mapView.setRegion(region, animated: true)
        
        newPin.coordinate = location.coordinate
        
        newPin.title = adrressStr
        
        
        mapView.addAnnotation(newPin)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backtap(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
       
        
        
        // Dispose of any resources that can be recreated.
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

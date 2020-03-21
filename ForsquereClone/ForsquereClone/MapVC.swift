//
//  MapVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 19.03.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "SAVE", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "<= GERI", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(recognizer)
    }
    
    @objc func chooseLocation(gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            PlaceModel.sharedInstance.placeChoosenLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeChoosenLongitude = String(coordinates.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveButtonClicked(){
        
         let placeModel = PlaceModel.sharedInstance
         
         let object = PFObject(className: "Places")
         object["name"] = placeModel.placeName
         object["type"] = placeModel.placeType
         object["comment"] = placeModel.placeComment
         object["latitude"] = placeModel.placeChoosenLatitude
         object["longitude"] = placeModel.placeChoosenLongitude
         
         if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5){
             object ["image"] = PFFileObject(name: "image.jpeg", data: imageData)
         }
         
         object.saveInBackground { (success, error) in
             if error != nil{
                 let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                 let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                 alert.addAction(okButton)
                 self.present(alert, animated: true, completion: nil)
             }else{
                 self.performSegue(withIdentifier: "mapVCtoPlacesVC", sender: nil)
             }
         }
        
    }
    
    @objc func backButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }

}

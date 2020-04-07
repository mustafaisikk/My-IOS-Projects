//
//  FriendsPlacesDetailsVC.swift
//  ForsquereClone
//
//  Created by Mustafa IŞIK on 1.04.2020.
//  Copyright © 2020 Mustafa ISIK. All rights reserved.
//

import UIKit
import MapKit
import Parse

class FriendsPlacesDetailsVC: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var friendsPlaceImage: UIImageView!
    @IBOutlet weak var friendsPlaceName: UILabel!
    @IBOutlet weak var friendsPlaceType: UILabel!
    @IBOutlet weak var friendsPlaceComment: UILabel!
    @IBOutlet weak var FriendsPlaceMapView: MKMapView!
    
    var choosenId = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FriendsPlaceMapView.delegate = self
        getDataPromParse()
    }
    
    func getDataPromParse(){
        let friendsPlaceQuery = PFQuery(className: "Places")
        friendsPlaceQuery.whereKey("objectId", equalTo: self.choosenId)
        friendsPlaceQuery.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAllert(titleInput: "Error", messageInput: error?.localizedDescription ?? "")
            }else {
                if objects != nil {
                    let choosenPlaceObject = objects![0]
                    if let placeName = choosenPlaceObject.object(forKey: "name") as? String {
                        self.friendsPlaceName.text = placeName
                    }
                    if let placeType = choosenPlaceObject.object(forKey: "type") as? String {
                        self.friendsPlaceType.text = placeType
                    }
                    if let placeComment = choosenPlaceObject.object(forKey: "comment") as? String {
                        self.friendsPlaceComment.text = placeComment
                    }
                    if let placeLatitude = choosenPlaceObject.object(forKey: "latitude") as? String {
                        if let placeLatitudeDouble = Double(placeLatitude) {
                            self.choosenLatitude = placeLatitudeDouble
                        }
                    }
                    if let placeLongitude = choosenPlaceObject.object(forKey: "longitude") as? String {
                        
                        if let placeLongitudeDouble = Double(placeLongitude) {
                            self.choosenLongitude = placeLongitudeDouble
                        }
                    }
                    if let imageData = choosenPlaceObject.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { (data, error) in
                            if error == nil {
                                if data != nil {
                                    self.friendsPlaceImage.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
                    
                    let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.FriendsPlaceMapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.friendsPlaceName.text!
                    annotation.subtitle = self.friendsPlaceType.text!
                    self.FriendsPlaceMapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
    
    func makeAllert(titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reusId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reusId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reusId)
            pinView?.canShowCallout = true
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLatitude != 0.0 && self.choosenLongitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlacemark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlacemark)
                        mapItem.name = self.friendsPlaceName.text
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }

}

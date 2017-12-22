//
//  AddPhotoVC.swift
//  PhotoLibrary
//
//  Created by Matt Baker on 2/29/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class AddPhotoVC: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageTitle: UITextField!
    @IBOutlet weak var imageLocation: UILabel!
    @IBOutlet weak var imagePhoto: UIImageView!
    
    var locationManager = CLLocationManager()
    
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        let realm = try! Realm()
        
        let imageData = ImageData()
        imageData.location = imageLocation.text!
        imageData.title = imageTitle.text!
        imageData.photo = UIImageJPEGRepresentation(imagePhoto.image!, 0.7)
        
        try! realm.write() {
            realm.add(imageData)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Change view to camera to allow user to take picture
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = UIImagePickerControllerSourceType.camera
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
        
        //Get user location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestLocation()
        }
    }
    
}

extension AddPhotoVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("Authorized Obtained For Location")
            manager.requestLocation()
        } else {
            print("Warning: Authorized NOT Obtained For Location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) {
                (placemarks, error) in
                if error != nil {
                    print("ERROR: Reverse Geocode Failed")
                    return
                }
                
                if let placemark = placemarks!.first {
                    guard let
                        city = placemark.locality,
                        let state = placemark.administrativeArea
                        else {
                            return
                    }
                    let displayString = "\(city), \(state)"
                    self.imageLocation.text = displayString
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Do nothing
    }
}

extension AddPhotoVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let userImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else {
                return
        }
        imagePhoto.image = userImage
        
        dismiss(animated: true, completion: nil)
    }
}

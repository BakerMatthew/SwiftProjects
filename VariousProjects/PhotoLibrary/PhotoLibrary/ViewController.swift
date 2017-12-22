//
//  ViewController.swift
//  PhotoLibrary
//
//  Created by Matt Baker on 2/29/16.
//  Copyright © 2016 usu. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    var images: Results<ImageData>!
    var realm: Realm!
    var selectedRow = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Realm data into images
        realm = try! Realm()
        images = realm.objects(ImageData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoSegue" {
            let photoVC = segue.destination as! imageVC
            photoVC.imageData = images[selectedRow]
        }
    }
    
    
    @IBAction func deleteData(_ sender: AnyObject) {
        try! realm.write() {
            realm.deleteAll()
        }
        collectionView.reloadData()
    }

}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
                
        cell.setPhotoData = images[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "photoSegue", sender: self)
    }
}


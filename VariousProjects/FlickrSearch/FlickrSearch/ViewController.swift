//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Matt Baker on 2/18/16.
//  Copyright © 2016 usu. All rights reserved.
//

// Flickr Key Info
// Key: 2724b9c5fb28143434db07e6a47d8112
// Secret: d1f28a191ad4da3e


import UIKit

// Main ViewController
class ViewController: UIViewController {
    var collectionData = [FlickrPhoto]()
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedRow = 0

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoSegue" {
            let photoVC = segue.destination as! ImageViewController
            photoVC.flickrPhoto = collectionData[selectedRow]
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        FlickrManager.search(searchBar.text!) {
			(photos) in
            DispatchQueue.main.async {
                self.collectionData = photos
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: FlickrCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FlickrCell
        
        if cell == nil {
            collectionView.register(UINib(nibName: "FlickrCell", bundle: nil), forCellWithReuseIdentifier: "cell")
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FlickrCell
        }
        cell.setFlickrPhoto = collectionData[indexPath.row]
		
		
        return cell
    }
	
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "photoSegue", sender: self)
    }
	
}

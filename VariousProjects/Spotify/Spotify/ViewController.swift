//
//  ViewController.swift
//  Spotify
//
//  Created by Matt Baker on 2/05/16.
//  Copyright © 2016 USU. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var tableData = [SpotifyTrack]()
    var player: AVPlayer!
    @IBOutlet weak var tableView: UITableView!
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		SpotifyManager.search(searchText) {
            (tracks) in
            DispatchQueue.main.async {
                self.tableData = tracks
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: "custom") as? CustomCell
        
        if cell == nil {
            tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "custom")
            cell = tableView.dequeueReusableCell(withIdentifier: "custom") as? CustomCell
        }
		
        cell.setSpotifyTrack = tableData[indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: tableData[indexPath.row].previewUrl)
			else { return }
        player = AVPlayer(url: url)
        player.play()
    }
}

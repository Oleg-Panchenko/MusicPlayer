//
//  SearchMusicViewController.swift
//  IMusic
//
//  Created by Panchenko Oleg on 27.05.2022.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchMusicViewController: UITableViewController {
    
    var networkService = NetworkService()
    let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        var content = cell.defaultContentConfiguration()
        content.image = #imageLiteral(resourceName: "albumPic")
        content.text = "\(track.trackName)\n\(track.artistName)"
        cell.contentConfiguration = content
//        cell.imageView?.image = #imageLiteral(resourceName: "albumPic")
        return cell
    }
}

//MARK: - UISearchBarDelegate
extension SearchMusicViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
        
            self.networkService.fetchTracks(searchText: searchText) { [weak self] (searchResults) in
                
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
}

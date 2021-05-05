//
//  ViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import UIKit

class ViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private let service = MediaService()
    
    private var requestOptions = RequestOptions()
    private var results = [ResultData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchBar()

    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }
}

// MARK: Configure SearchBar
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            requestOptions.term = text
            fetchMedia(options: requestOptions)
        }
    }
    
}


// MARK: Fetching Data
extension ViewController {
    func fetchMedia(options: RequestOptions) {
        DispatchQueue.global().async {
            self.service.fetchMedia(options: options) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let mediaData):
                    print(mediaData)
                }
            }
        }
    }
}


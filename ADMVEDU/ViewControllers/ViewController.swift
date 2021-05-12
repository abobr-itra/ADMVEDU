//
//  ViewController.swift
//  ADMVEDU
//
//  Created by Bobr, Andrey on 4.05.21.
//

import UIKit

class ViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private var tableView = UITableView()

    private let service = MediaService()
    private var requestOptions = RequestOptions()
<<<<<<< HEAD
    private var results = [ResultData]()
    weak var delegate: DetailsDelegate?
   
=======
    private var results: [ResultData] = [ResultData]()
>>>>>>> 115

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchBar()
        configureTableView()
<<<<<<< HEAD
        configureNavController()

    }

    func configureNavController() {
        navigationController?.navigationBar.backgroundColor = .clear
       // navigationController?.navigationBar.prefersLargeTitles = true
        let filterButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toFilter))
        navigationItem.rightBarButtonItem = filterButton
    }

    @objc
    func toFilter() {
        let filterVC = FilterViewController()
        filterVC.delegate = self
        filterVC.requestOptions = requestOptions
        let navVC = UINavigationController(rootViewController: filterVC)
        present(navVC, animated: true)

=======
>>>>>>> 115
    }

    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
    }

    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.register(UINib(nibName: MediaCell.nibName, bundle: nil),
                           forCellReuseIdentifier: MediaCell.nibName)
        tableView.rowHeight = 75
        tableView.pin(to: view)
        tableView.backgroundColor = .clear
    }

    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
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

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.isActive = false
        searchBar.text = requestOptions.term
    }
}

// MARK: Configure TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaCell.nibName) as? MediaCell else {
            return MediaCell()
        }
        let result = results[indexPath.row]
        cell.set(media: result)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = results[indexPath.row]
        let detailsVC = DetailsViewController()
        detailsVC.media = result

        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ViewController {
    func fetchMedia(options: RequestOptions) {
        print(options)
        DispatchQueue.global().async {
            self.service.fetchMedia(options: options) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let mediaData):
                    if let data = mediaData.results {
                        self.updateView(with: data)
                    }
                }
            }
        }
    }

    func updateView(with data: [ResultData]) {
        DispatchQueue.main.async {
            self.results = data
            self.tableView.reloadData()
        }
    }
}

extension ViewController: OptionsDelegate {
    func setOptions(with requestOptions: RequestOptions) {
        self.requestOptions = requestOptions
    }
}

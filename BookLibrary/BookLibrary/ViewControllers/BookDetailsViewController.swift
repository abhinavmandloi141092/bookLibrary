//
//  BookDetailsViewController.swift
//  BookLibrary
//
//  Created by Abhinav Mandloi on 29/05/19.
//  Copyright © 2019 Abhinav Mandloi. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var bookDetailsTableView: UITableView!
    
    private var bookLibrarySearchController: UISearchController = UISearchController()
    public var dataModelForDetails: Array<BookData> = []
    private var searchData: Array<BookData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchData = dataModelForDetails
        self.registerCellNibs()
        self.setUpUI()
        
        self.bookLibrarySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.bookDetailsTableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        self.bookDetailsTableView.tableFooterView = UIView()
        self.bookDetailsTableView.reloadData()
    }
    
    
    /// Register Nibs
    private func registerCellNibs() {
        let nib = UINib(nibName: Constants.kBookDetailsTableViewCell, bundle: nil)
        self.bookDetailsTableView.register(nib, forCellReuseIdentifier: Constants.kBookDetailsTableViewCell)
    }
    
    private func setUpUI() {
        //self.bookDetailsTableView.tableHeaderView = self.searchBar
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension BookDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kBookDetailsTableViewCell, for: indexPath) as! BookDetailsTableViewCell
        cell.selectionStyle = .none
        cell.bookData = self.dataModelForDetails[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
}

// MARK: - UISearchResultsUpdating
extension BookDetailsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text!.count > 0 {
            self.searchData.removeAll(keepingCapacity: false)
            let data = self.dataModelForDetails.filter { (s: BookData) -> Bool in
                return searchController.searchBar.text! == s.author_name || searchController.searchBar.text! == s.author_country || searchController.searchBar.text! == s.genre
            }
            self.searchData = data
            
        } else {
            self.searchData = self.dataModelForDetails
        }
        self.bookDetailsTableView.reloadData()
    }
}

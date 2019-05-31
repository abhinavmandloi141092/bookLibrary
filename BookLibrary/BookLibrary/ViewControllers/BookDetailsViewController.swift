//
//  BookDetailsViewController.swift
//  BookLibrary
//
//  Created by Abhinav Mandloi on 29/05/19.
//  Copyright © 2019 Abhinav Mandloi. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bookDetailsTableView: UITableView!
    
    /// For Bool Details Data
    public var dataModelForDetails: Array<BookData> = []
    
    /// For storing searchData
    private var searchData: Array<BookData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCellNibs()
        
        self.searchData = dataModelForDetails
        searchBar.delegate = self
    }
    
    /// Register Nibs
    private func registerCellNibs() {
        let nib = UINib(nibName: Constants.kBookDetailsTableViewCell, bundle: nil)
        self.bookDetailsTableView.register(nib, forCellReuseIdentifier: Constants.kBookDetailsTableViewCell)
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
        cell.bookData = self.searchData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
}


// MARK: - UISearchBarDelegate
extension BookDetailsViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            self.searchData = self.dataModelForDetails
            self.bookDetailsTableView.reloadData()
            return
        }
        
        self.searchData.removeAll()
        for dict in self.dataModelForDetails {
            if dict.book_title.lowercased().contains(searchText.lowercased()) || dict.author_name.lowercased().contains(searchText.lowercased()) ||
                dict.genre.lowercased().contains(searchText.lowercased()) {
                self.searchData.append(dict)
            }
        }
        self.bookDetailsTableView.reloadData()
    }
}



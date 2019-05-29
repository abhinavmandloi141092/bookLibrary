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
    private var dataArr: Array<String> = ["numberOfRowsInSection","forCellReuseIdentifier","bookDetailsTableView","searchBar","String"]
    public var dataModelForDetails: Array<BookData> = []
    private var searchData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        if self.bookLibrarySearchController.isActive {
            return self.searchData.count
        }
        return self.dataArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kBookDetailsTableViewCell, for: indexPath) as! BookDetailsTableViewCell
        cell.selectionStyle = .none
        if self.bookLibrarySearchController.isActive {
            cell.lbl_Title.text = self.searchData[indexPath.row] + "\(indexPath.row + 1000)"
        }
        else {
            cell.lbl_Title.text = self.dataArr[indexPath.row] + "\(indexPath.row + 1000)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
}


// MARK: - UISearchResultsUpdating
extension BookDetailsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (self.dataArr as NSArray).filtered(using: searchPredicate)
        self.searchData = array as! [String]
        
        self.bookDetailsTableView.reloadData()
    }
}

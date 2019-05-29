//
//  BookListViewController.swift
//  BookLibrary
//
//  Created by Abhinav Mandloi on 29/05/19.
//  Copyright © 2019 Abhinav Mandloi. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    
    @IBOutlet weak var bookListTableView: UITableView!
    private var serverHelper: ServerHelper = ServerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookListTableView.tableFooterView = UIView()
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serverHelper.getDataFromJSONFile().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.kCell)
        cell.selectionStyle = .none
        cell.textLabel?.text = "Name \(indexPath.row + 20)"//self.serverHelper.getDataFromJSONFile()[indexPath.row].book_title
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        headerView.backgroundColor = UIColor.lightGray
        
        let divideView = UIView(frame: CGRect(x: 0, y: headerView.frame.height - 1, width: UIScreen.main.bounds.width, height: 1))
        divideView.backgroundColor = UIColor.darkGray
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 49))
        titleLabel.text = Constants.kBooksLibrary
        
        headerView.addSubview(divideView)
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetailsViewController: UIViewController = UIStoryboard(name: Constants.kStoryBoardName, bundle: nil).instantiateViewController(withIdentifier: Constants.kBookDetailsViewController)
        if let navigator = self.navigationController {
            navigator.pushViewController(bookDetailsViewController, animated: true)
        }
    }
}
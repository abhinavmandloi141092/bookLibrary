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
    @IBOutlet weak var lbl_Error: UILabel!
    
    private var serverHelper: ServerHelper = ServerHelper()
    private var bookListData: Set<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookListTableView.tableFooterView = UIView()
        self.modifingData()
    }
    
    private func modifingData() {

        if self.serverHelper.getDataFromJSONFile().count == 0 {
            self.bookListTableView.isHidden = true
            self.lbl_Error.text = Constants.kErrorMessage
        }
        else {
            self.bookListTableView.isHidden = false
            for data in self.serverHelper.getDataFromJSONFile() {
                self.bookListData.insert(data.author_name)
                self.bookListData.insert(data.genre)
                self.bookListData.insert(data.author_country)
            }
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookListData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.kCell)
        cell.selectionStyle = .none
        cell.textLabel?.text = self.bookListData[self.bookListData.index(self.bookListData.startIndex, offsetBy: indexPath.row)]
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
        let bookDetailsViewController: BookDetailsViewController = UIStoryboard(name: Constants.kStoryBoardName, bundle: nil).instantiateViewController(withIdentifier: Constants.kBookDetailsViewController) as! BookDetailsViewController
        
        let seletedName = self.bookListData[self.bookListData.index(self.bookListData.startIndex, offsetBy: indexPath.row)]
        let data = self.serverHelper.getDataFromJSONFile().filter { (s: BookData) -> Bool in
            return seletedName == s.author_name || seletedName == s.author_country || seletedName == s.genre
        }
        
        bookDetailsViewController.dataModelForDetails = data
        
        if let navigator = self.navigationController {
            navigator.pushViewController(bookDetailsViewController, animated: true)
        }
    }
}

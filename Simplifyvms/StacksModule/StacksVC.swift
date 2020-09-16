//
//  StacksVC.swift
//  Simplifyvms
//
//  Created by surendra kumar k on 11/09/20.
//  Copyright © 2020 Semanoor. All rights reserved.
//

import UIKit


let BASEURL = "https://api.stackexchange.com/2.2/"
let BlogsInfoUrl = BASEURL + "search?order=desc&sort=activity&intitle=perl&site=stackoverflow&pagesize=10&page="

//https://api.stackexchange.com/2.2/search?page=1&pagesize=10&order=desc&min=10&sort=activity&intitle=perl&site=stackoverflow

class StacksVC: UIViewController {
    
    var searchBarHeright: NSLayoutConstraint?
    var searchActive : Bool = false

    var blogsArray : [Item]? = [] {
        didSet {
            tableview.isHidden = false
            tableview.reloadData()
        }
    }
    var filterArray : [Item]? = []
    private let emptyStateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as! EmptyStateView
    
    private var stocksData : BlogStocksModel? = nil
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0 //pageNo*limit
    var didEndReached:Bool=false

    
    
    lazy var searchField:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search Items"
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true;
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = UIColor.Simplify.DarkBlue
        searchBar.autocapitalizationType = .none
        return searchBar

    }()

    
    
    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.delegate = (self as UITableViewDelegate)
        tableView.dataSource = (self as UITableViewDataSource)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stacks Info"
        self.ConfigureViews()
        
    }
    
    
    func ConfigureViews()
    {
        view.addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        searchBarHeright = searchField.heightAnchor.constraint(equalToConstant: 50)
        searchBarHeright?.isActive = true
        searchField.delegate = self
        
        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let nibName = UINib(nibName: "BlogCell", bundle:nil)
        tableview.register(nibName, forCellReuseIdentifier: "BlogCell")
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 100

        //Bsckground refresh
        registerForNotifications()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getBlogDetails(pageIndex:self.pageNo)
    }
    
    func registerForNotifications() {
       NotificationCenter.default.addObserver(
         forName: .newItemsFetched,
         object: nil,
         queue: nil) { (notification) in
           print("notification received")
           if let uInfo = notification.userInfo,
              let itemsInfo = uInfo["items"] as? Any {
           }
       }
     }
    
    
    
     func getBlogDetails(pageIndex : Int)
    {
        if (NetworkManager.sharedInstance.reachability.isConnectedToNetwork()) {
            self.emptyStateView.removeFromSuperview()
            let url : String? = "\(BlogsInfoUrl)\(pageIndex)"
            WebServices.shared.getServiceCall(type: BlogStocksModel.self, urlString: url!, requiredToken: false, view: self.view, animateIndicator: true)
            {  (response) in
                do {
                    DispatchQueue.main.async {
                        self.stocksData = response
                        guard self.stocksData?.items != nil else {
                            ErrorManager.showErrorAlert(mainTitle: "", subTitle: "error")
                            return }
                        if (self.blogsArray != nil) {
                            self.searchActive = false
                            self.blogsArray?.append(contentsOf: (self.stocksData?.items)!)
                        }
                    }
                }
                catch let error {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
                }
            }
        }else{
            tableview.isHidden = true
            self.emptyStateView.values(headerTitle: "", stateImage: UIImage(named: "internet")!, title: "Oops! No internet connection", subTitle: "Please check your internet connection and try again", stateActionTitle: "Try again")
            self.emptyStateView.stateAction.addTarget(self, action: #selector(self.tryInternetConnection), for: .touchUpInside)
            self.view.addSubview(self.emptyStateView)
        }
    }

    
    @objc func tryInternetConnection()
    {
        self.getBlogDetails(pageIndex:self.pageNo)
    }
   
    
}


//MARK:- UITableView Module

extension StacksVC : UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchActive {
            if self.filterArray!.count >= 1 {
                self.tableview.restore()
                return self.filterArray!.count
            }else{
                self.tableview.setEmptyMessage("Sorry, No items found!, \n try Something else")
            }
        }else{
            if self.blogsArray!.count >= 1 {
                return self.blogsArray!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
        var eachBlog : Item? = nil
        if self.searchActive && self.filterArray!.count >= 1  {
            eachBlog = self.filterArray?[indexPath.row]
        }else{
            eachBlog = self.blogsArray?[indexPath.row]
        }
        if eachBlog != nil  {
            cell.titleLabel.text = eachBlog?.title
            let string = self.getString(array: (eachBlog?.tags)!)
            cell.tagsView.text = string
            cell.blogBtn.eachItem = eachBlog
            cell.blogBtn.addTarget(self, action: #selector(favItemSelected(sender:)), for: .touchUpInside)
            cell.blogBtn.tag = indexPath.row
            if (eachBlog?.isSelectedFav)! {
                cell.blogBtn.setImage(#imageLiteral(resourceName: "star-trek"), for: .normal)
            }else{
                cell.blogBtn.setImage(#imageLiteral(resourceName: "RadioDeselected"), for: .normal)
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            var spinner = UIActivityIndicatorView(style:.gray)
            if #available(iOS 13.0, *) {
                 spinner = UIActivityIndicatorView(style:.medium)
            } else {
                // Fallback on earlier versions
                 spinner = UIActivityIndicatorView(style:.gray)
            }
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            if lastRowIndex < 8 {
                tableView.tableFooterView?.isHidden = true
            }
        }else{
            tableView.tableFooterView = nil
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchField.resignFirstResponder()
    }
    
     //Pagination to load more items
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         if ((tableview.contentOffset.y + tableview.frame.size.height) >= tableview.contentSize.height)
         {
             if !isDataLoading{
                 isDataLoading = true
                 self.pageNo=self.pageNo+1
                 self.getBlogDetails(pageIndex: self.pageNo)
             }
         }
     }


    
    func getString(array : [String]) -> String {
        let stringArray = array.map{ String($0) }
        return stringArray.joined(separator: ",")
    }
       
    //Selection of each item adding
    @objc func favItemSelected(sender:BlogBuuton){
        
        do {
            sender.isSelected = !sender.isSelected
            var eachBlog : Item? = nil
            if self.searchActive {
                if self.filterArray!.count >= 1 {
                    eachBlog = self.filterArray?[sender.tag]
                }
            }else{
                if self.blogsArray!.count >= 1 {
                    eachBlog = self.blogsArray?[sender.tag]
                }
            }
            if eachBlog != nil  {
                if sender.isSelected {
                    eachBlog?.isSelectedFav = true
                }else{
                    eachBlog?.isSelectedFav = false
                }
                if let index = WebServices.shared.userCartData?.index(where: {$0.owner?.userID == eachBlog?.owner?.userID}) {
                    WebServices.shared.userCartData?.remove(at: index)
                }else{
                    WebServices.shared.userCartData?.append(eachBlog!)
                }
                if let index = self.blogsArray?.index(where: {$0.owner?.userID == eachBlog?.owner?.userID}) {
                    self.blogsArray?[index] = eachBlog!
                }
                if self.searchActive {
                    self.filterArray?[sender.tag] = eachBlog!
                }
                tableview.reloadData()
            }
        }
        catch let error {
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
        }
    }

}


extension StacksVC : UISearchBarDelegate {
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
                self.searchActive = false
                self.tableview.reloadData()
            }
        }
    }
    
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true
        self.filterArray?.removeAll()
    }
    

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
        self.searchField.resignFirstResponder()
        self.tableview.reloadData()
    }
    
    //filter search results
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        do {
            self.searchActive = true
            let searchString = searchBar.text?.trimWhiteSpace()
            if searchString != "", searchString!.count > 0 {
                filterArray?.removeAll()
                if let text = searchField.text {
                    filterArray = self.blogsArray?.filter{
                        ($0.title.lowercased().contains(text.lowercased())) ||  ($0.tags?.contains(text))!
                    }
                }
            }
            tableview.reloadData()
            self.searchField.resignFirstResponder()
        } catch let error {
            ErrorManager.showErrorAlert(mainTitle: "", subTitle: error.localizedDescription)
        }
   }

    
}


extension String {
    func trimWhiteSpace() -> String {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return string
    }
}

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
    }
}


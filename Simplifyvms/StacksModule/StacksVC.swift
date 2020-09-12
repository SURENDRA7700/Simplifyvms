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

class StacksVC: UIViewController, UITextFieldDelegate {
    
    var searchBarHeright: NSLayoutConstraint?
    var blogsArray : [Item]? = [] {
        didSet {
            tableview.reloadData()
        }
    }
    
    private var stocksData : BlogStocksModel? = nil
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0 //pageNo*limit
    var didEndReached:Bool=false


    
    let searchField: CustomSearchBar = {
        let bar = CustomSearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = "Search Items"
        bar.setRightViewIcon(imageName: "searchIcon")
        bar.layer.cornerRadius = 25
        bar.keyboardType = .webSearch
        bar.textAlignment = .natural
        return bar
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
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        searchBarHeright = searchField.heightAnchor.constraint(equalToConstant: 50)
        searchBarHeright?.isActive = true
        searchField.delegate = self;
        
        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let nibName = UINib(nibName: "BlogCell", bundle:nil)
        tableview.register(nibName, forCellReuseIdentifier: "BlogCell")
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 200

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getBlogDetails(pageIndex:self.pageNo)

        
    }
    
    private func getBlogDetails(pageIndex : Int)
    {
        let url : String? = "\(BlogsInfoUrl)\(pageIndex)"
        WebServices.shared.getServiceCall(type: BlogStocksModel.self, urlString: url!, requiredToken: false, view: self.view, animateIndicator: true)
        {  (response) in
            DispatchQueue.main.async {
                self.stocksData = response
                guard self.stocksData?.items != nil else {
                    ErrorManager.showErrorAlert(mainTitle: "", subTitle: "error")
                    return }
                ErrorManager.showSuccessAlert(mainTitle: "Success iTEMS \(self.stocksData?.items?.count)", subTitle: "")
                if (self.blogsArray != nil) {
                    self.blogsArray?.append(contentsOf: (self.stocksData?.items)!)
                }
            }
        }
    }

   
    
}


extension StacksVC : UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blogsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath) as! BlogCell
        let eachBlog = self.blogsArray?[indexPath.row]
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
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }else{
            tableView.tableFooterView = nil
        }
    }

     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         isDataLoading = false
     }
    
     //Pagination
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
       
    
    @objc func favItemSelected(sender:BlogBuuton){
        sender.isSelected = !sender.isSelected
        var eachBlog = self.blogsArray?[sender.tag]
        if sender.isSelected {
            eachBlog?.isSelectedFav = true
            WebServices.shared.userCartData?.append(eachBlog!)
        }else{
            eachBlog?.isSelectedFav = false
            WebServices.shared.userCartData?.remove(at: sender.tag)
        }
        self.blogsArray?[sender.tag] = eachBlog!
        tableview.reloadData()
    }

}
    

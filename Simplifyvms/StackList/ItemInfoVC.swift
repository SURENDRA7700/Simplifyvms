//
//  ItemInfoVC.swift
//  Simplifyvms
//
//  Created by surendra kumar k on 11/09/20.
//  Copyright © 2020 Semanoor. All rights reserved.
//

import UIKit

class ItemInfoVC: UIViewController {
    
    @IBOutlet weak var cartEmptyLabel: UILabel!
    var blogsArray : [Item]? = [] {
        didSet {
            tableview.reloadData()
        }
    }
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
        self.title = "Selected Items"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.blogsArray = WebServices.shared.userCartData
        if self.blogsArray!.isEmpty {
            self.cartEmptyLabel.isHidden = false
            self.tableview.isHidden = true
        }else{
            self.cartEmptyLabel.isHidden = true
            self.tableview.isHidden = false
            ErrorManager.showSuccessAlert(mainTitle: "", subTitle: "Cat has \(self.blogsArray?.count ?? 0) Items")
            self.configureTbleView()
        }
    }
    
    func configureTbleView()
    {
        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let nibName = UINib(nibName: "BlogCell", bundle:nil)
        tableview.register(nibName, forCellReuseIdentifier: "BlogCell")
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 120
    }
    
}


extension ItemInfoVC : UITableViewDelegate, UITableViewDataSource
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
        cell.blogBtn.tag = indexPath.row
        cell.blogBtn.isHidden = true
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func getString(array : [String]) -> String {
        let stringArray = array.map{ String($0) }
        return stringArray.joined(separator: ",")
    }
}



//
//  MemberListingViewController.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import UIKit

class MemberListingViewController: UIViewController
{
    @IBOutlet weak var tblMembers: UITableView!
    
    var members = [Member]()
    {
        didSet
        {
            filterAndDisplay()
        }
    }
    var filteredMembersArray = [Member]()
    {
        didSet
        {
            tblMembers?.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUp()
    }
    
    
    func setUp()
    {
        title = "\(members.count) Members"
        tblMembers.tableFooterView = UIView()
    }
    
    func filterAndDisplay()
    {
        filteredMembersArray = members
    }
}

extension MemberListingViewController : UITableViewDelegate,UITableViewDataSource
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredMembersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MemberCell
        cell.configureCell(member: filteredMembersArray[indexPath.row])
        return cell
    }
}

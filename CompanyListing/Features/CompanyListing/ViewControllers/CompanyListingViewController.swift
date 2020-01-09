//
//  CompanyListingViewController.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyListingViewController: UIViewController
{
    @IBOutlet weak var tblCompanies: UITableView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    var companyArray = [Company]()
    {
        didSet
        {
            filterAndDisplay()
        }
    }
    
    var filteredCompanyArray = [Company]()
    {
        didSet
        {
            tblCompanies.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUp()
    }
    
    
    func setUp()
    {
        title = "Companies"
        loaderView.isHidden = false
        NetworkLayer.shared.getCompanies {[weak self] (companies, isSuccess, msg) in
            if isSuccess
            {
                self?.companyArray = companies
            }
            else
            {
                print(msg)
            }
            self?.loaderView.isHidden = true
        }
        tblCompanies.tableFooterView = UIView()
    }
    
    func filterAndDisplay()
    {
        filteredCompanyArray = companyArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destVc = segue.destination as? MemberListingViewController, let company = sender as? Company
        {
            destVc.members = company.members
        }
    }
}


extension CompanyListingViewController : UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching
{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredCompanyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CompanyCell
        cell.configureCell(company: filteredCompanyArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])
    {
        let urls = indexPaths.compactMap {filteredCompanyArray[$0.row].logo.url}
        ImagePrefetcher(urls: urls).start()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: Constants.Segues.toMembers, sender: filteredCompanyArray[indexPath.row])
    }
}

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
    @IBOutlet weak var btnNameSort: UIButton!
    
    var companyArray = [Company]()
    {
        didSet
        {
            filterAndDisplay()
        }
    }
    
    var filteredCompanyArray = [Company]()
    var selectedSortOrder: SortOrder = .ascending
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUp()
        setupSeachBar()
    }
    
    /*
    * Intial setup
    */
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
        btnNameSort.setTitle("SORT NAME BY: ASCENDING", for: .normal)
    }
    
    /*
    *  Setup search bar
    */
    func setupSeachBar()
    {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name"
        searchController.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    /*
    * Filters and display contents
    */
    func filterAndDisplay()
    {
        guard let text = searchController.searchBar.text else { return }
        if text.isEmpty
        {
           filteredCompanyArray = companyArray
        }
        else
        {
            filteredCompanyArray = companyArray.filter { (company: Company) -> Bool in
                return company.company.lowercased().contains(text.lowercased())
           }
        }
        let resultType = selectedSortOrder == .ascending ? ComparisonResult.orderedAscending : ComparisonResult.orderedDescending
        filteredCompanyArray = filteredCompanyArray.sorted
        {
            return $0.company.localizedCaseInsensitiveCompare($1.company) == resultType
        }
        tblCompanies.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destVc = segue.destination as? MemberListingViewController, let company = sender as? Company
        {
            destVc.members = company.members
        }
    }
    
    /*
    * Select sort order
    */
    @IBAction func selectSortOrder(_ sender: Any)
    {
        let alert = UIAlertController(title: "Sort Order", message: "Select sort order for companies", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ascending", style: .default, handler:{ (UIAlertAction)in
            self.btnNameSort.setTitle("SORT NAME BY: ASCENDING", for: .normal)
            self.selectedSortOrder = .ascending
            self.filterAndDisplay()
        }))
        
        alert.addAction(UIAlertAction(title: "Descending", style: .default, handler:{ (UIAlertAction)in
            self.btnNameSort.setTitle("SORT NAME BY: DESCENDING", for: .normal)
            self.selectedSortOrder = .descending
            self.filterAndDisplay()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        }))

        self.present(alert, animated: true, completion:
        {
            print("completion block")
        })
    }
}

/*
* Tableview delegates
*/
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

/*
* UISearchResults delegates
*/
extension CompanyListingViewController: UISearchResultsUpdating
{
    // MARK: - Search result update
    func updateSearchResults(for searchController: UISearchController)
    {
        filterAndDisplay()
    }
}

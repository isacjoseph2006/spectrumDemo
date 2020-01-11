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
    @IBOutlet weak var btnNameSortOrder: UIButton!
    @IBOutlet weak var btnAgeSortOrder: UIButton!
    
    var ageSortOrder: SortOrder = .ascending
    var nameSortOrder: SortOrder = .ascending
    var searchController = UISearchController(searchResultsController: nil)
    
    var members = [Member]()
    {
        didSet
        {
            filterAndDisplay(withName: true)
        }
    }
    
    /*
     * Holds the filtered memebers
     */
    var filteredMembersArray = [Member]()
    
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
        title = "\(members.count) Members"
        tblMembers.tableFooterView = UIView()
        self.btnNameSortOrder.setTitle("SORT NAME: ASCENDING", for: .normal)
        self.btnAgeSortOrder.setTitle("SORT AGE: ASCENDING", for: .normal)
    }
    
    /*
     * Setups the search bar
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
    * Filters and displays the results
    */
    func filterAndDisplay(withName:Bool)
    {
        guard let text = searchController.searchBar.text else { return }
        if text.isEmpty
        {
            filteredMembersArray = members
        }
        else
        {
            filteredMembersArray = members.filter { (member: Member) -> Bool in
                return member.name.displayName.lowercased().contains(text.lowercased())
            }
        }
        
        let resultTypeName = nameSortOrder == .ascending ? ComparisonResult.orderedAscending : ComparisonResult.orderedDescending
        
        if withName
        {
            filteredMembersArray = filteredMembersArray.sorted
            {
                if $0.name.displayName == $1.name.displayName
                {
                    return ageSortOrder == .ascending ? $0.age > $0.age : $0.age < $0.age
                }
                else
                {
                    return $0.name.displayName.localizedCaseInsensitiveCompare($1.name.displayName) == resultTypeName
                }
            }
        }
        else
        {
            filteredMembersArray = filteredMembersArray.sorted
            {
                if $0.age == $1.age
                {
                    return $0.name.displayName.localizedCaseInsensitiveCompare($1.name.displayName) == resultTypeName
                }
                else
                {
                    return ageSortOrder == .ascending ? $0.age > $1.age : $0.age < $1.age
                }
            }
        }
        
        tblMembers?.reloadData()
    }
    
    /*
    * Show sort options
    */
    @IBAction func selectNameSortOrder(_ sender: Any)
    {
        let alert = UIAlertController(title: "Sort Order", message: "Select sort order for Members", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ascending", style: .default, handler:{ (UIAlertAction)in
            self.btnNameSortOrder.setTitle("SORT NAME: ASCENDING", for: .normal)
            self.nameSortOrder = .ascending
            self.filterAndDisplay(withName: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Descending", style: .default, handler:{ (UIAlertAction)in
            self.btnNameSortOrder.setTitle("SORT NAME: DESCENDING", for: .normal)
            self.nameSortOrder = .descending
            self.filterAndDisplay(withName: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        }))

        self.present(alert, animated: true, completion:
        {
            print("completion block")
        })
    }
    
    /*
    * Show sort options
    */
    @IBAction func selectAgeSortOrder(_ sender: Any)
    {
        let alert = UIAlertController(title: "Sort Order", message: "Select sort order for Age", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ascending", style: .default, handler:{ (UIAlertAction)in
            self.btnAgeSortOrder.setTitle("SORT AGE: ASCENDING", for: .normal)
            self.ageSortOrder = .ascending
            self.filterAndDisplay(withName: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Descending", style: .default, handler:{ (UIAlertAction)in
            self.btnAgeSortOrder.setTitle("SORT AGE: DESCENDING", for: .normal)
            self.ageSortOrder = .descending
            self.filterAndDisplay(withName: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
        }))

        self.present(alert, animated: true, completion:
        {
            print("completion block")
        })
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

/*
* UISearchResults delegates
*/
extension MemberListingViewController: UISearchResultsUpdating
{
    // MARK: - Search result update
    func updateSearchResults(for searchController: UISearchController)
    {
        filterAndDisplay(withName: true)
    }
}

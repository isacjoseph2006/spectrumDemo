//
//  CompanyCell.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import UIKit
import Kingfisher

class CompanyCell: UITableViewCell
{
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var btnWebUrl: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var btnFollow: UIButton!
    
    
    var selectedCompany: Company!
        
    override func awakeFromNib()
    {
        super.awakeFromNib()
        imgLogo.layer.cornerRadius = 5.0
        btnFollow.layer.cornerRadius = 5.0
        btnFollow.layer.borderWidth = 1.0
        btnFollow.layer.borderColor = UIColor.systemBlue.cgColor
    }

    /*
    * Configure cells
    */
    func configureCell(company:Company)
    {
        selectedCompany = company
        lblCompanyName.text = selectedCompany.company
        lblDesc.text = selectedCompany.about
        btnWebUrl.setTitle(selectedCompany.website, for: .normal)
        lblDesc.isHidden = selectedCompany.about.isEmpty
        lblCompanyName.isHidden = selectedCompany.company.isEmpty
        btnWebUrl.isHidden = selectedCompany.website.isEmpty
        imgLogo.kf.setImage(with: selectedCompany.logo.url)
        btnFav.isSelected = selectedCompany.isFavourite
        let followTitle = selectedCompany.isFollowing ? "UNFOLLOW" : "FOLLOW"
        btnFollow.setTitle(followTitle, for: .normal)
    }
    
    /*
    * User clciks favourite button
    */
    @IBAction func favClicked(_ sender: UIButton)
    {
        selectedCompany.isFavourite = !sender.isSelected
        sender.isSelected = selectedCompany.isFavourite
    }
    
    /*
    * User clciks on website
    */
    @IBAction func websiteClicked(_ sender: Any)
    {
        //Added https:// to make a url a valid one
        guard let url = "https://\(selectedCompany.website)".url,UIApplication.shared.canOpenURL(url) else
        {
          return //be safe
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    /*
    * User clciks on follow button
    */
    @IBAction func followingCliked(_ sender: Any)
    {
        selectedCompany.isFollowing = !selectedCompany.isFollowing
        configureCell(company: selectedCompany)
    }
    
    /*
    * Resets UI elements on reuse
    */
    override func prepareForReuse()
    {
        lblCompanyName.text = nil
        lblDesc.text = nil
        btnWebUrl.setTitle(nil, for: .normal)
        btnFav.isSelected = false
        btnFollow.setTitle("FOLLOW", for: .normal)
    }

}

//
//  MemberCell.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    
    var selectedMemeber: Member!
    
    /*
     * Configures the cell
     */
    func configureCell(member: Member)
    {
        selectedMemeber = member
        lblName.text = "\(selectedMemeber.name.displayName) (Age: \(selectedMemeber.age))"
        btnPhone.setTitle(selectedMemeber.phone, for: .normal)
        btnEmail.setTitle(selectedMemeber.email, for: .normal)
        btnFav.isSelected = selectedMemeber.isFavourite
    }
    
    /*
    * User clicked on fav button
    */
    @IBAction func favClicked(_ sender: UIButton)
    {
        selectedMemeber.isFavourite = !sender.isSelected
        sender.isSelected = selectedMemeber.isFavourite
    }
    
    /*
    * User tries to click on email
    */
    @IBAction func emailClicked(_ sender: Any)
    {
        if let url = "mailto:\(selectedMemeber.email)".url,UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }
    
    /*
    * User clicks on phoine number
    */
    @IBAction func phoneClicked(_ sender: Any)
    {
        if let url = "tel://\(selectedMemeber.phone.replacingOccurrences(of: " ", with: ""))".url,UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }
    
    /*
    * Resets the uielements on resuse
    */
    override func prepareForReuse()
    {
        lblName.text = nil
        btnEmail.setTitle(nil, for: .normal)
        btnFav.isSelected = false
        btnPhone.setTitle(nil, for: .normal)
    }
    
}

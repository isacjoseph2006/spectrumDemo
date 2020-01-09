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
    
    
    func configureCell(member: Member)
    {
        selectedMemeber = member
        lblName.text = "\(selectedMemeber.name.displayName) (Age: \(selectedMemeber.age))"
        btnPhone.setTitle(selectedMemeber.phone, for: .normal)
        btnEmail.setTitle(selectedMemeber.email, for: .normal)
        btnFav.isSelected = selectedMemeber.isFavourite
    }
    
    @IBAction func favClicked(_ sender: UIButton)
    {
        selectedMemeber.isFavourite = !sender.isSelected
        sender.isSelected = selectedMemeber.isFavourite
    }
    
    @IBAction func emailClicked(_ sender: Any)
    {
        if let url = "mailto:\(selectedMemeber.email)".url,UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func phoneClicked(_ sender: Any)
    {
        if let url = "tel://\(selectedMemeber.phone.replacingOccurrences(of: " ", with: ""))".url,UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }
    
    
    override func prepareForReuse()
    {
        lblName.text = nil
        btnEmail.setTitle(nil, for: .normal)
        btnFav.isSelected = false
        btnPhone.setTitle(nil, for: .normal)
    }
    
}

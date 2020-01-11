//
//  Members.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import Foundation

struct Member: Codable
{
    var _id: String
    var age: Int
    var name: Name
    var email: String
    var phone: String
    
    /*
    * Favourites are written in userdefaults
    */
    var isFavourite: Bool
    {
        set
        {
            UserDefaults.standard.set(newValue, forKey: "\(Constants.UserDefaultKeys.memberFavPrefix)\(_id)")
        }
        
        get
        {
            return UserDefaults.standard.bool(forKey: "\(Constants.UserDefaultKeys.memberFavPrefix)\(_id)")
        }
    }
}

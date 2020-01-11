//
//  Company.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import Foundation


struct Company :Codable
{
    var _id: String
    var company: String
    var website: String
    var logo: String
    var about: String
    var members: [Member]
    
    /*
    * Favourites are written in userdefaults
    */
    var isFavourite: Bool
    {
        set
        {
            UserDefaults.standard.set(newValue, forKey: "\(Constants.UserDefaultKeys.companyFavPrefix)\(_id)")
        }
        
        get
        {
            return UserDefaults.standard.bool(forKey: "\(Constants.UserDefaultKeys.companyFavPrefix)\(_id)")
        }
    }
    
    /*
    * Following are written in userdefaults
    */
    var isFollowing: Bool
    {
        set
        {
            UserDefaults.standard.set(newValue, forKey: "\(Constants.UserDefaultKeys.companyFollowPrefix)\(_id)")
        }
        
        get
        {
            return UserDefaults.standard.bool(forKey: "\(Constants.UserDefaultKeys.companyFollowPrefix)\(_id)")
        }
    }
}

//
//  Constants.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import Foundation

struct Constants
{
    struct Urls
    {
        static let homeUrl = "https://next.json-generator.com/api/json/get/Vk-LhK44U"
    }
    
    struct Messages
    {
        static let internetIssue = "You are not connected to internet"
        static let invalidUrl = "Url is not valid"
        static let commonError     = "We are not able to perform this request – please check that you are connected to the internet and retry. Thank you."
    }
    
    struct Segues
    {
        static let toMembers = "toMembersVC"
    }
    
    struct UserDefaultKeys
    {
        static let companyFavPrefix = "compFav"
        static let companyFollowPrefix = "compFollow"
        static let memberFavPrefix = "memFav"
    }
    
}

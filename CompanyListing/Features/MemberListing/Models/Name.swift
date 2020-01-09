//
//  Name.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import Foundation

struct Name :Codable
{
    var first: String
    var last: String
    
    var displayName: String
    {
        return first + last
    }
}

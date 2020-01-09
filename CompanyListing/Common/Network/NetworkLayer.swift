//
//  Constants.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import Foundation
import Alamofire

class NetworkLayer: NSObject
{
    static let shared = NetworkLayer()
    let alamofireManager = Alamofire.SessionManager()
    
    private override init() {}
    
    
    func getCompanies(completion: @escaping (_ companies: [Company], _ success: Bool, _ message: String) -> Void)
    {
        guard let url = Constants.Urls.homeUrl.url else
        {
            completion([Company](),false,Constants.Messages.invalidUrl)
            return
        }
        
        guard NetworkReachabilityManager()!.isReachable else
        {
            completion([Company](),false,Constants.Messages.internetIssue)
            return
        }
        
        alamofireManager.request(url, method:.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON
        { response in
         
            guard response.result.isSuccess,let data = response.data else
            {
                completion([Company](),false,Constants.Messages.commonError)
                return
            }
            
            do
            {
                let companies = try JSONDecoder().decode([Company].self, from: data)
                completion(companies,true,"")
            }
            catch
            {
                completion([Company](),false,error.localizedDescription)
            }
            
        }
    }
}

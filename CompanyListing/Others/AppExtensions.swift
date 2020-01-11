//
//  AppExtensions.swift
//  CompanyListing
//
//  Created by Isac Joseph on 09/01/20.
//  Copyright © 2020 Isac Joseph. All rights reserved.
//

import Foundation
import UIKit

/*
 * Returns back an optional URL variable from string
 */
extension String
{
    var url :URL?
    {
        return URL(string: self)
    }
}

/*
* Displays alert
*/
extension UIViewController
{
    func displayAlert(title:String,msg:String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true)
    }
}

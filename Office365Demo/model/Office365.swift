//
//  Office365.swift
//  Office365Demo
//
//  Created by Mehmet Sen on 3/18/16.
//  Copyright © 2016 Mehmet Sen. All rights reserved.
//

import Foundation
import UIKit

class Office365 {
    
    var tenant: String
    var authority: String
    var clientID: String
    let redirectUri: NSURL
    let discoveryResource: String
    
    init(clientID: String, redirectUri: String){
        
        self.clientID = clientID
        self.redirectUri = NSURL(string: redirectUri)!
        self.tenant = "nau3203.onmicrosoft.com"
        self.authority = "https://login.windows.net/\(self.tenant)"
        self.discoveryResource = "https://api.office.com/discovery"
    }
    
    class func getInstance() -> Office365{
        
        //enter client ID and redirect uri
        let office365 = Office365(clientID: "blablabla", redirectUri: "http://xtalkapp.com/office365clientios/oauth2.php")
        
        return office365
        
    }
}

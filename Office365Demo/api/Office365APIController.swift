//
//  Office365APIController.swift
//  Office365Demo
//
//  Created by Mehmet Sen on 3/18/16.
//  Copyright © 2016 Mehmet Sen. All rights reserved.
//

import Foundation

class Office365APIController{
    
    let office365: Office365 = Office365.getInstance()
   
    init(){}
    
    func login(completionHandler:((Bool, String) -> Void)){
        
        let err: AutoreleasingUnsafeMutablePointer<ADAuthenticationError?> = nil
        let authContext: ADAuthenticationContext = ADAuthenticationContext(authority: office365.authority, error: err)
        
        authContext.acquireTokenWithResource(office365.discoveryResource, clientId: office365.clientID, redirectUri: office365.redirectUri, completionBlock: {(result: ADAuthenticationResult!)  in
            
            //validate token exists in response
            if result.status.rawValue != AD_SUCCEEDED.rawValue {//login not successful
                completionHandler(false, result.error.description)
                
            }else{ //login successful
                
                print("user email: \(result.tokenCacheStoreItem.userInformation.userId)")
                
                //save email
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setObject(result.tokenCacheStoreItem.userInformation.userId, forKey: "email")
                userDefaults.synchronize()
                
                completionHandler(true, result.accessToken)
                
            }
            
            
        })
        
    }
    
    // Logout function to clear the app's cache and remove the user's information.
    func logout() {
        var error: ADAuthenticationError?
        let cache: ADTokenCacheStoring = ADAuthenticationSettings.sharedInstance().defaultTokenCacheStore
        // Clear the token cache
        let allItemsArray = cache.allItemsWithError(&error)
        if (!allItemsArray.isEmpty) {
            cache.removeAllWithError(&error)
        }
        // Remove all the cookies from this application's sandbox. The authorization code is stored in the
        // cookies and ADAL will try to get to access tokens based on auth code in the cookie.
        let cookieStore = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        if let cookies = cookieStore.cookies {
            for cookie in cookies {
                cookieStore.deleteCookie(cookie )
            }
        }
    }
    
}





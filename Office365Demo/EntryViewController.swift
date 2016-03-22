//
//  ViewController.swift
//  Office365Demo
//
//  Created by Mehmet Sen on 3/18/16.
//  Copyright © 2016 Mehmet Sen. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var btnOffice365Login: UIButton!
 
    var baseController = Office365ClientFetcher()
    var serviceEndpointLookup = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectToOffice365()
    }
    
    func connectToOffice365() {
        // Connect to the service by discovering the service endpoints and authorizing
        // the application to access the user's email. This will store the user's
        // service URLs in a property list to be accessed when calls are made to the
        // service. This results in two calls: one to authenticate, and one to get the
        // URLs. ADAL will cache the access and refresh tokens so you won't need to
        // provide credentials unless you sign out.
        
        // Get the discovery client. First time this is ran you will be prompted
        // to provide your credentials which will authenticate you with the service.
        // The application will get an access token in the response.
        
        baseController.fetchDiscoveryClient { (discoveryClient) -> () in
            let servicesInfoFetcher = discoveryClient.services
            
            // Call the Discovery Service and get back an array of service endpoint information
            
            let servicesTask = servicesInfoFetcher.readWithCallback{(serviceEndPointObjects:[AnyObject]!, error:MSOrcError!) -> Void in
                let serviceEndpoints = serviceEndPointObjects as! [MSDiscoveryServiceInfo]
                
                if (serviceEndpoints.count > 0) {
                    // Here is where we cache the service URLs returned by the Discovery Service. You may not
                    // need to call the Discovery Service again until either this cache is removed, or you
                    // get an error that indicates that the endpoint is no longer valid.
                    
                    var serviceEndpointLookup = [NSObject: AnyObject]()
                    
                    for serviceEndpoint in serviceEndpoints {
                        serviceEndpointLookup[serviceEndpoint.capability] = serviceEndpoint.serviceEndpointUri
                    }
                    
                    print(serviceEndpointLookup)
                    
                    // Keep track of the service endpoints in the user defaults
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    userDefaults.setObject(serviceEndpointLookup, forKey: "O365ServiceEndpoints")
                    userDefaults.synchronize()
                    
                    //jump to the main tab bar
                    let mainTabBar: UITabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("mainTabBar") as! UITabBarController
                    self.presentViewController(mainTabBar, animated: false, completion: nil)
                    
                   
                }
                    
                else {
                    dispatch_async(dispatch_get_main_queue()) {
                        NSLog("Error in the authentication: %@", error)
                        let alert: UIAlertView = UIAlertView(title: "Error", message: "Authentication failed. This may be because the Internet connection is offline  or perhaps the credentials are incorrect. Check the log for errors and try again.", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                }
            }
            
            
        }
    }
    


}


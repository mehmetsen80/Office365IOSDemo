//
//  ViewController.swift
//  Office365Demo
//
//  Created by Mehmet Sen on 3/18/16.
//  Copyright © 2016 Mehmet Sen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnOffice365Login: UIButton!
    var loggedIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func loginWith365(sender: AnyObject) {
        
        let authMgr: Office365APIController = Office365APIController()
        if (loggedIn){
            // Logout and change the button to read "Log in"
            authMgr.logout()
            self.btnOffice365Login.setTitle("Log in with Office365", forState: UIControlState.Normal)
            self.loggedIn = false
            
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if let email: String = userDefaults.stringForKey("email") {
                self.lblEmail.text = email
            }
        }
        else {
            self.lblEmail.text = ""
            // Attempt to get a token
            authMgr.login() {
                (authenticated: Bool, token: String) -> Void in
                if (authenticated) {
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        // Change the button to read "Log out"
                        NSLog("Authentication successful, token: %@", token)
                        self.btnOffice365Login.setTitle("Log out Office365", forState: UIControlState.Normal)
                        self.loggedIn = true
                        
                        let userDefaults = NSUserDefaults.standardUserDefaults()
                        if let email: String = userDefaults.stringForKey("email") {
                            self.lblEmail.text = email
                        }
                        
                    })
                }
                else {
                    NSLog("Authentication failed: %@", token)
                }
            }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


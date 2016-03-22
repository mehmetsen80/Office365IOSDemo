//
//  ProfileViewController.swift
//  Office365Demo
//
//  Created by Mehmet Sen on 3/21/16.
//  Copyright © 2016 Mehmet Sen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        let authMgr: Office365APIController = Office365APIController.sharedInstance
        authMgr.logout()
        
        //jump to the entry view controller which is the first screen
        let entryView: EntryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("entryView") as! EntryViewController
        self.presentViewController(entryView, animated: false, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

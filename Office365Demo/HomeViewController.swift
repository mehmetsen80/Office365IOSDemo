//
//  HomeViewController.swift
//  Office365Demo
//
//  Created by Mehmet Sen on 3/21/16.
//  Copyright © 2016 Mehmet Sen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let authMgr: Office365APIController = Office365APIController.sharedInstance
    var messages = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //get the messages
        self.getMessages(authMgr.dependencyResolver)
    }
    
    
    func getMessages(dependencyResolver: ADALDependencyResolver) {
        var apiEndpoint = "https://outlook.office365.com/api/v2.0"
        var client: MSOutlookClient = MSOutlookClient(url: apiEndpoint, dependencyResolver: dependencyResolver)
        // Select at most 10 messages (.top(10))
        // Return only the subject, date/time received, and from fields (.select())
        // Sort by date/time received, newest first (.orderBy())
    
//        client.me. messages.top(10).select("Subject,DateTimeReceived,From").orderBy("DateTimeReceived DESC").readWithCallback({
//            (messages: [AnyObject]!, error: MSOrcError!) -> Void in
//            dispatch_async(dispatch_get_main_queue(), {
//                () -> Void in
//                for msg in messages {
//                    var olMsg: MSOutlookMessage = msg as! MSOutlookMessage
//                    NSLog(olMsg.Subject)
//                }
//            })
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  WebViewController.swift
//  FoodPin
//
//  Created by wang jing on 29/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    
    
    @IBOutlet var webview:UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL (string:"http://www.appcoda.com/contact"){
            let request = NSURLRequest(URL:url)
            webview.loadRequest(request)
        }

        // Do any additional setup after loading the view.
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

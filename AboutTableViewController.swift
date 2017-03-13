//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by wang jing on 29/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    
        //store the section title
        var selectionTitles = ["Leave Feedback", "Follow Us"]
        var selectionContent = [["Rate us on app store","Tell us your feedback"], ["Twitter","Facebook","Pinterest"]]
        var links = ["http://twitter.com/appcodamobile", "http://facebook.com/appcodamobile", "http://pinterest.com/appcoda/"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //remove the separator for blank table row
        tableView.tableFooterView = UIView(frame:CGRectZero)
        
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 2
        }else {
            return 3
        }
    }
    //set title
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return selectionTitles[section]
    }
    
    
    // set text label
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = selectionContent[indexPath.section][indexPath.row]

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url=NSURL(string: "http://www.apple.com/itunes/charts/paid-apps/"){
                    UIApplication.sharedApplication().openURL(url)
                }
                //"tell us your feedback cell"
            }else if indexPath.row == 1 {
                performSegueWithIdentifier("showWebView", sender: self)
            }
            
         //handle social profilr item
        case 1:
            if let url = NSURL(string:links[indexPath.row]){
                let safariController = SFSafariViewController(URL: url, entersReaderIfAvailable:true)
                presentViewController(safariController, animated: true, completion: nil)
            }
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

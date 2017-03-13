//
//  DiscoverTableViewController.swift
//  FoodPin
//
//  Created by wang jing on 29/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import CloudKit

class DiscoverTableViewController: UITableViewController {
    
    //declare a restaurant variable that store an array of CKRecord
    //it will be used to store the records fetched fro mthe cloud
    var restaurants:[CKRecord] = []
    
    @IBOutlet var spinner:UIActivityIndicatorView!
    
    var imageCache:NSCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()
        //control whether the indicator is hiden when animation is stopped
        spinner.hidesWhenStopped = true
        //place the indicator in the center of the view
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        
        
        

        
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        getRecordsFromCloud()
        
                // pull to refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.whiteColor()
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: #selector(DiscoverTableViewController.getRecordsFromCloud), forControlEvents: UIControlEvents.ValueChanged)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DiscoveryTableViewCell

        // Configure the cell...
        let restaurant = restaurants[indexPath.row]
        
       // cell.textLabel?.text = restaurant.objectForKey("name") as? String
        cell.restaurantName.text = restaurant.objectForKey("name") as? String
        cell.restaurantType.text = restaurant.objectForKey("type") as? String
        cell.restaurantLocation.text = restaurant.objectForKey("location") as? String


        
        /******************************lazy loading image****************************************/
        
        //set default image
      //  cell.imageView?.image=UIImage(named: "photoalbum")
        
        cell.restaurantImage.image = UIImage(named: "photoalbum")
        
        /******************************using catch image****************************************/
        if let imageFielURL = imageCache.objectForKey(restaurant.recordID) as? NSURL {
            //ferch image from catch
            print("Get image from catch")
          //  cell.imageView?.image = UIImage (data:NSData (contentsOfURL: imageFielURL)!)
            cell.restaurantImage.image = UIImage (data:NSData (contentsOfURL: imageFielURL)!)
            
        }
        else {
        /******************************using catch image****************************************/
        
        
        
        //fetch image from cloud in background 
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        let fetRecordImageOperation = CKFetchRecordsOperation(recordIDs:[restaurant.recordID])
        fetRecordImageOperation.desiredKeys = ["image"]
        fetRecordImageOperation.queuePriority = .VeryHigh
        
        fetRecordImageOperation.perRecordCompletionBlock = {(record:CKRecord?,recordID:CKRecordID?,error:NSError?) -> Void in
            if error != nil {
                print("Failed to get restaurant image:\(error!.localizedDescription)")
                return
            }
            
            if let restaurantRecord = record {
                NSOperationQueue.mainQueue().addOperationWithBlock(){
                    if let imageAsset = restaurantRecord.objectForKey("image") as? CKAsset {
                       // cell.imageView?.image = UIImage (data: NSData (contentsOfURL: imageAsset.fileURL)!)
                        
                        cell.restaurantImage.image = UIImage (data: NSData (contentsOfURL: imageAsset.fileURL)!)
                    }
                }
            }
        }
        
        publicDatabase.addOperation(fetRecordImageOperation)
        }
        
        /******************************lazy loading image****************************************/
        
        
        if let image = restaurant.objectForKey("image") {
            let imageAsset = image as! CKAsset
            //cell.imageView?.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
            cell.restaurantImage.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
        }
        

        return cell
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
    
    func getRecordsFromCloud(){
    
        
//        /*************************************fetch data using convenience API**********************/
//        
//        
//        //get the default CloudKit container
//        let cloudContainer = CKContainer.defaultContainer()
//        //ontian the defaultpublic fatabase
//        let publicDatabase = cloudContainer.publicCloudDatabase
//        //search criteria
//        let predicate = NSPredicate(value: true)
//        //construct a CKQuery object with restaurant to 
//        let query = CKQuery(recordType: "Restaurant",predicate: predicate)
//        //query method
//        // only suitable for retrieve a small amount of data
//        publicDatabase.performQuery(query, inZoneWithID: nil, completionHandler: {(results, error)-> Void in
//            //check error
//            if error != nil {
//                print(error)
//                return
//            }
//            if let results = results {
//                self.restaurants = results
//                //reload the table view
//                
//                //the data reload sholud be in the main thread
//                NSOperationQueue.mainQueue().addOperationWithBlock(){
//                    self.tableView.reloadData()
//                }
//            }
//        
//    
//        })
//    }
//    
//     /*************************************fetch data using convenience API**********************/
    
     /*************************************fetch data using operational API**********************/
    
        //get the default CloudKit container
        let cloudContainer = CKContainer.defaultContainer()
        //obtian the default public database
        let publicDatabase = cloudContainer.publicCloudDatabase
        //search criteria
        let predicate = NSPredicate(value: true)
        //construct a CKQuery object with restaurant to
        let query = CKQuery(recordType: "Restaurant",predicate: predicate)
        
        // sort the data
        query.sortDescriptors = [NSSortDescriptor(key:"creationDate",ascending: false)]
        
        
        //create the query operation with the query
        let queryOperation = CKQueryOperation (query: query)
        //specify the fields to fetch
      //  queryOperation.desiredKeys = ["name", "image"]
        
        /******************************lazy loading image****************************************/
        queryOperation.desiredKeys = ["name","type","location"]
        /*******************************lazy loading image***************************************/
        
        
        //specify the execution priority
        queryOperation.queuePriority = .VeryHigh
        //set the maximun number of record at any one time
        queryOperation.resultsLimit = 50
        
        self.restaurants.removeAll();
        
        // execute every time a record return
        queryOperation.recordFetchedBlock = {(record: CKRecord!) -> Void in
            if let restaurantRecord = record {
                
                self.restaurants.append(restaurantRecord)
            }
        }
        
        //execute after all the record are fetched
        queryOperation.queryCompletionBlock = {(cursor:CKQueryCursor?, error: NSError?) -> Void in
            if (error != nil) {
                print("Failed to get data from iCloud - \(error!.localizedDescription)")
                return
            }
            
            print("Sucessfully retrieve the data from iCloud")
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                self.spinner.stopAnimating()
                self.tableView.reloadData()
                
            }
            //when the data is ready, hide the control
            
            self.refreshControl?.endRefreshing()
        }
        
            //execute the query operation
            publicDatabase.addOperation(queryOperation)
    }
        
        /*************************************fetch data using operational API**********************/
    
}



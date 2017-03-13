//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 14/8/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    var restaurants:[Restaurant] = []
    
    var fetchResultController:NSFetchedResultsController!
    
    var searchController:UISearchController!
    //declear a new variable to store the search result
    var searchResults:[Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Enable self sizing cells
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Load the restaurants from database
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                
                //return an array of AnyObject, and cast it to restaurant
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            } catch {
                print(error)
            }
        }
        
        // Adding a search bar
        
        /*create an instance
        nil means the search result would be display in the same view that you are searching*/
        searchController = UISearchController(searchResultsController: nil)
        
        // Add searchbar
        tableView.tableHeaderView = searchController.searchBar
        
        // current class as the search result undater
        searchController.searchResultsUpdater = self
        
        // DIM the table view
        searchController.dimsBackgroundDuringPresentation = false
        
        // Customize the appearance of the search bar
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        searchController.searchBar.barTintColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.6)
        
        

        
        
        
    }
    

    
    
    //    var restuarantIsVisited=[Bool](count:21,repeatedValue:false)
    //    var restaurantNames=["Cafe Deadend",
    //                        "Homei",
    //                        "Teakha",
    //                        "Cafe Loisl",
    //                        "Petite Oyster",
    //                        "For Kee Restaurant",
    //                        "Po's Atelier",
    //                        "Bourke Street Bakery",
    //                        "Haigh's Chocolate",
    //                        "Palomino Espresso",
    //                        "Upstate", "Traif",
    //                        "GrahamAvenue Meats And Deli",
    //                        "Waffle & Wolf", "Five Leaves",
    //                        "Cafe Lore",
    //                        "Confessional",
    //                        "Barrafina",
    //                        "Donostia",
    //                        "Royal Oak",
    //                        "CASK Pub and Kitchen"]
    //
    //    var restaurantImages = ["cafedeadend.jpg",
    //                            "homei.jpg",
    //                            "teakha.jpg",
    //                            "cafeloisl.jpg",
    //                            "petiteoyster.jpg",
    //                            "forkeerestaurant.jpg",
    //                            "posatelier.jpg",
    //                            "bourkestreetbakery.jpg",
    //                            "haighschocolate.jpg",
    //                            "palominoespresso.jpg",
    //                            "upstate.jpg",
    //                            "traif.jpg",
    //                            "grahamavenuemeats.jpg",
    //                            "wafflewolf.jpg",
    //                            "fiveleaves.jpg",
    //                            "cafelore.jpg",
    //                            "confessional.jpg",
    //                            "barrafina.jpg",
    //                            "donostia.jpg",
    //                            "royaloak.jpg",
    //                            "thaicafe.jpg"]
    //
    //    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
    //                               "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York",
    //                               "London", "London", "London", "London"]
    //    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian /Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American /Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]

    
    //call when a view will about ot display
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true

    }
    
    override func viewDidAppear(animated: Bool) {
        
            super.viewDidAppear(animated)
        

        /**********************************present the pageview controller************************/
        
        let defaults=NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        
        if hasViewedWalkthrough {
            return
        }
        
        if let PageViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController") as? WalkthroughPageViewController {
                presentViewController(PageViewController, animated: true, completion: nil)
            }
    }



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        // Configure the cell...
        
        //        cell.nameLabel.text=restaurantNames[indexPath.row]
        //        cell.locationLabel.text=restaurantLocations[indexPath.row]
        //        cell.typeLabel.text=restaurantTypes[indexPath.row]
        //        cell.thumbnailImageView.image=UIImage(named: restaurantImages[indexPath.row])
        
        //        cell.nameLabel.text=restaurants[indexPath.row].name
        //        cell.locationLabel.text=restaurants[indexPath.row].location
        //        cell.typeLabel.text=restaurants[indexPath.row].type
        //
        //      //  cell.thumbnailImageView.image=UIImage(named: restaurants[indexPath.row].image)
        //        /********************************create data model ********************************/
        //        cell.thumbnailImageView.image = UIImage(data: restaurants[indexPath.row].image!)
        //
        //        //add circle for image
        //        cell.thumbnailImageView.layer.cornerRadius=30
        //        cell.thumbnailImageView.clipsToBounds=true
        //
        ////        if restuarantIsVisited[indexPath.row] {
        ////            cell.accessoryType = .Checkmark
        ////        }else{
        ////            cell.accessoryType = .None
        ////        }
        //
        ////        if restaurants[indexPath.row].isVisited {
        ////            cell.accessoryType = .Checkmark
        ////        }else{
        ////            cell.accessoryType = .None
        ////        }
        //        if ((restaurants[indexPath.row].isVisited? .boolValue) != nil) {
        //            cell.accessoryType = .Checkmark
        //        }else {
        //            cell.accessoryType = .None
        //        }
        
        
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        
        if let isVisited = restaurant.isVisited?.boolValue {
            cell.accessoryType = isVisited ? .Checkmark : .None
        }
        
        return cell
    }
    
    
    ////    after select the cell
    //    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        //create an option menu as an action sheet
    //        let optionMenu = UIAlertController(title: nil,message: "What do you want to do?",preferredStyle: .ActionSheet)
    //
    //        //Add cancel actions to the Menu
    //        let cancelAction=UIAlertAction(title: "Cancel", style:.Cancel, handler: nil)
    //        optionMenu.addAction(cancelAction)
    //
    //        /********************************press the call button, add call action**********************/
    //
    //        //{(action:UIAlertAction!)-> parameters of Closure
    //        // void--Return type of Closure
    //
    //        //add call action
    //        let callActionHandler={(action:UIAlertAction!)-> Void in
    //
    //            /********************BODY OF CLOSURE *****************/
    //            let alertMessage=UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. please retry later.", preferredStyle: .Alert)
    //            alertMessage.addAction(UIAlertAction(title: "OK",style: .Default, handler: nil))
    //            self.presentViewController(alertMessage,animated:true,completion:nil)
    //        }
    //
    //       let callAction=UIAlertAction(title: "Call"+"123-00-\(indexPath.row)", style: UIAlertActionStyle.Default, handler:callActionHandler)
    //
    //        optionMenu.addAction(callAction)
    //
    //
    //        //add check mark
    //        let isVisitedAction = UIAlertAction (title: "I've been here",style: .Default,
    //                                            handler: {
    //                                                (action:UIAlertAction!)-> Void in
    //
    //                                                let cell=tableView.cellForRowAtIndexPath(indexPath)
    //                                                cell?.accessoryType = .Checkmark
    //                                                self.restuarantIsVisited[indexPath.row]=true
    //        })
    //
    //        if restuarantIsVisited[indexPath.row] {
    //            let alertMessage=UIAlertController(title: "invalidated action", message: "this item has been selected", preferredStyle: .Alert)
    //            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    //                self.presentViewController(alertMessage,animated:true,completion:nil)
    //
    //        }else{
    //            optionMenu.addAction(isVisitedAction)
    //        }
    //
    //
    //
    //        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    //        //display the Menu
    //        self.presentViewController(optionMenu,animated:true,completion:nil)
    //        
    //        
    //    }
    
    // MARK: - Table view delegate
 
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            //            // Delete the row from the data source
            //            /*******deleted the data from data model ******/
            //            restaurantNames.removeAtIndex(indexPath.row)
            //            restaurantLocations.removeAtIndex(indexPath.row)
            //            restaurantTypes.removeAtIndex(indexPath.row)
            //            restaurantImages.removeAtIndex(indexPath.row)
            //            restuarantIsVisited.removeAtIndex(indexPath.row)
            //            /********************reload the UITABLE VIEW********************************/
            //           // tableView.reloadData()
            
            restaurants.removeAtIndex(indexPath.row)
        }
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action, indexPath) -> Void in
            
            
            //  let defaultText="Just checking in at "+self.restaurantNames[indexPath.row]
            
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            
            //share image
            // if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]){
            
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
        })
        
        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            // Delete the row from the data source
            /*******deleted the data from data model ******/
            //            self.restaurantNames.removeAtIndex(indexPath.row)
            //            self.restaurantLocations.removeAtIndex(indexPath.row)
            //            self.restaurantTypes.removeAtIndex(indexPath.row)
            //            self.restaurantImages.removeAtIndex(indexPath.row)
            //            self.restuarantIsVisited.removeAtIndex(indexPath.row)
            //            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // Delete the row from the database
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
            }
            
            //            self.restaurants.removeAtIndex(indexPath.row)
            ////            restaurants.removeAtIndex(indexPath.row).name
            ////            restaurants.removeAtIndex(indexPath.row).type
            ////            restaurants.removeAtIndex(indexPath.row).image
            ////            restaurants.removeAtIndex(indexPath.row).isVisited
            //            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        })
        
        // Set the button color
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)

        return [deleteAction, shareAction]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //find the next view by identifier
        if segue.identifier == "showRestaurantDetail" {
            
            //select the row
            if let indexPath = tableView.indexPathForSelectedRow {
                
                // instance the destination view
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                
                //trasit the data the destination
                // destinationController.restaurantImage = restaurantImages[indexPath.row]
                // destinationController.restaurant=restaurants[indexPath.row]
                
                destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
                
                
                //hide the tab bar
                destinationController.hidesBottomBarWhenPushed = true
            }
            
        }
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
            
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        
        default:
            tableView.reloadData()
        }
            
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    // MARK: - Search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        searchResults = restaurants.filter({(restaurant:Restaurant) -> Bool in
            
            //rangeOfString--see if the restaurant name contains the search text
            let searchScope = restaurant.name+restaurant.location
            //  let nameMatch=restaurant.name.rangeOfString(searchText,options: NSStringCompareOptions.CaseInsensitiveSearch)
            let match = searchScope.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            //if the text is not found, returns nil
            return match != nil
        })
    }
}


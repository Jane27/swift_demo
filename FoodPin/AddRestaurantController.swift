//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Simon Ng on 31/8/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import CloudKit
import CoreData

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView:UIImageView!

    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var typeTextField:UITextField!
    @IBOutlet var locationTextField:UITextField!
    @IBOutlet var phoneNumberTextField:UITextField!
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    
    var isVisited = true
    
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            
            //ask user to give permission to access the sourcen
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                
                //call up present view controller to bring up the photo library
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //assign the image view with the selected image
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        // change the contentmode to scaleaspectfit
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        
        /********************************add layout constraint**************************************/
                    
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        leadingConstraint.active = true
        
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        trailingConstraint.active = true
                    
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        topConstraint.active = true
                    
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        bottomConstraint.active = true
        
        /********************************add layout constraint**************************************/
        //dismiss the image picker
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Action methods
    
    @IBAction func save(sender:UIBarButtonItem) {
        let name = nameTextField.text
        let type = typeTextField.text
        let location = locationTextField.text
        let phoneNumber = phoneNumberTextField.text
        
        // Validate input fields
        if name == "" || type == "" || location == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
            restaurant.name = name!
            restaurant.type = type!
            restaurant.location = location!
            restaurant.phoneNumber = phoneNumber!
            
            if let restaurantImage = imageView.image {
                restaurant.image = UIImagePNGRepresentation(restaurantImage)
            }
            restaurant.isVisited = isVisited
            
            //tell the contexxt to save the new object into the database by calling save method
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
                return
            }
        }
        
        //save data to cloud 
        saveRecordToCloud(restaurant)
        
        // Dismiss the view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        // Yes button clicked
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
            noButton.backgroundColor = UIColor.grayColor()
        } else if sender == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        }
    }
    //1. take in a restaurant object, used to save
    func saveRecordToCloud(restaurant:Restaurant)-> Void {
        //prepare the record to save
        //2. transfer the restaurant object to a CKRecord object
        let record = CKRecord(recordType: "Restaurant")
        record.setValue(restaurant.name, forKey: "name")
        record.setValue(restaurant.type, forKey: "type")
        record.setValue(restaurant.location, forKey: "location")
        record.setValue(restaurant.phoneNumber, forKey: "phone")
        
        //resize the image
        let originalImage = UIImage (data: restaurant.image!)!
        let scalingfactor = (originalImage.size.width > 1024) ? 1024 / originalImage.size.width:1.0
        //scale down the image
        let scaledImage = UIImage (data: restaurant.image!, scale: scalingfactor)
        
        //write the image to local file for temporary use
        //temporarily save the image in the temporary folder
        //NSTemporaryDirectory: get the path of the temporary directory
        
        let imageFilePath = NSTemporaryDirectory()+restaurant.name
        //UIImageJPEGRepresentation compress the image data and call writeToFile
        UIImageJPEGRepresentation(scaledImage!, 0.8)?.writeToFile(imageFilePath, atomically: true)
        
        
        //create image asset for upload
        let imageFileURL = NSURL(fileURLWithPath: imageFilePath)
        let imageAsset = CKAsset(fileURL:imageFileURL)
        record.setValue(imageAsset, forKey: "image")
        
        //get the public icoud database
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        
        //save the record to icloud
        publicDatabase.saveRecord(record, completionHandler: {(record:CKRecord?, error:NSError?) -> Void in
            // remove temp file
            do {
                try NSFileManager.defaultManager().removeItemAtPath(imageFilePath)
            }catch {
                print("Failed to save record to the cloud:\(error)")
            }
        })
        
        
        
    }
    
    
    
}

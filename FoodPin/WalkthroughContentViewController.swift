//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by wang jing on 10/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    
    
    @IBOutlet var headingLabel:UILabel!
    @IBOutlet var contentLabel:UILabel!
    @IBOutlet var contentImageView:UIImageView!
    
    
    @IBOutlet var pageControl:UIPageControl!
    
    @IBOutlet var forwardButton:UIButton!
    
    //store te current page index
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named:imageFile)
        
        
        pageControl.currentPage = index
        
        
        //show "next" button on the first two page and "done" on the last page 
        
        switch index {
        case 0...1:
            forwardButton.setTitle("Next", forState: UIControlState.Normal)
        case 2:
            forwardButton.setTitle("Done", forState: UIControlState.Normal)
        default:
            break
        }
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
    
    
    @IBAction func nextButtonTapped(sender:UIButton){

        switch index {
        case 0...1:
            let pageViewController = parentViewController as! WalkthroughPageViewController
            pageViewController.forward(index)
        case 2:
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "hasViewedWalkthrough")
            
            dismissViewControllerAnimated(true, completion: nil)
        default:
            break
        }
    }
    
//    @IBAction func close(sender:AnyObject){
//        
//        print("welll")
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setBool(true, forKey: "hasViewWalkthrough")
//        
//        dismissViewControllerAnimated(true, completion: nil)
//    }


}

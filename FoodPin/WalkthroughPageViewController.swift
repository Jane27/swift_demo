//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by wang jing on 10/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageContent = ["Pin your favourite restaurants and create your own food guide",
                       "Search and locate your favourite restaurant on Maps",
                       "Find restaurant pinned by your friends and other foodies around the world"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set the data source to itself
        dataSource = self
        
        //create tge first walkthough screen
        if let startingViewController = viewControllerAtIndex(0){
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
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
    




    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        //get the current page index of the iven view controller
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index:Int) -> WalkthroughContentViewController? {
        
        if index == NSNotFound || index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        //create a new view controller and pass suitable data
    
        if let pageContentViewController = storyboard? .instantiateViewControllerWithIdentifier("WalkthroughContentViewController") as? WalkthroughContentViewController{
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
            
        }
        
        return nil
        
        
    }
    
/************************************Adding Default Page Indicator******************************
    
    //return the total number of DOTS
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageHeadings.count
    }
    
    //return the index of the selected item
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContentViewController") as? WalkthroughContentViewController {
            
            return pageContentViewController.index
        }
        return 0
    }
 
************************************Adding a default Page Indicator******************************/
    
/************************************Adding a Custom Page Indicator******************************/
    
    
    func forward(index:Int)  {
        if let nextViewController = viewControllerAtIndex(index+1){
            setViewControllers([nextViewController], direction:.Forward,animated:true, completion:nil)
        }
    }

}




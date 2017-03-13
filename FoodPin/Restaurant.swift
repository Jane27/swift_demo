//
//  Restaurant.swift
//  FoodPin
//
//  Created by Simon Ng on 20/8/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import Foundation
import CoreData

class Restaurant:NSManagedObject {
    @NSManaged var name:String
    @NSManaged var type:String
    @NSManaged var location:String
    @NSManaged var phoneNumber:String?
    //NSDATA is binary data
    @NSManaged var image:NSData?
    //nsnumber is boolean (1---True or 0--False)
    @NSManaged var isVisited:NSNumber?
    @NSManaged var rating:String?
    
    //class Restaurant {
    //    var name=""
    //    var type=""
    //    var location=""
    //    var phoneNumber=""
    //    var image=""
    //    var rating=""
    //
    //    var isVisited=false
    //
    //    init(name:String, type:String, location: String, phoneNumber:String,image: String,  isVisited:Bool, rating:String)
    //{
    //    self.name=name;
    //    self.type=type;
    //    self.location=location
    //    self.image=image
    //    self.phoneNumber=phoneNumber
    //    self.isVisited=isVisited
    //    self.rating=rating
    //}
    //}
    
 //   var restaurants:[Restaurant] = [
        //    Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phoneNumber: "232-9234230" , image:"cafedeadend.jpg", isVisited: false, rating:"dislike.jpg"),
        //    Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phoneNumber: "348-233423", image:
        //        "homei.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "354-243523", image:
        //        "teakha.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "453-333423", image: "cafeloisl.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "983-284334", image:
        //            "petiteoyster.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop JK.,200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phoneNumber: "232-434222", image: "forkeerestaurant.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phoneNumber: "234-834322", image:"posatelier.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phoneNumber: "982-434343",
        //                image: "bourkestreetbakery.jpg", isVisited: false,rating:"ranting.jpg"),
        //    Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phoneNumber: "734-232323", image:
        //                "haighschocolate.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Palomino Espresso", type: "American / Seafood", location:
        //                "Shop 1 61 York St Sydney New South Wales", phoneNumber: "872-734343", image:
        //                "palominoespresso.jpg", isVisited: false,rating:"ranting.jpg"),
        //    Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", phoneNumber: "343-233221", image: "upstate.jpg", isVisited:false,rating:"rating.jpg"),
        //    Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phoneNumber: "985-723623", image: "traif.jpg", isVisited:
        //        false,rating:"rating.jpg"),
        //    Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch",
        //        location: "445 Graham Ave Brooklyn, NY 11211", phoneNumber: "455-232345",
        //        image: "grahamavenuemeats.jpg", isVisited: false,rating:"ranting.jpg"),
        //    Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phoneNumber: "434-232322", image:
        //        "wafflewolf.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", phoneNumber: "343-234553", image: "fiveleaves.jpg",
        //        isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phoneNumber: "342-455433", image:
        //        "cafelore.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phoneNumber: "643-332323", image: "confessional.jpg",
        //        isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phoneNumber: "542-343434", image:
        //        "barrafina.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phoneNumber: "722-232323", image:
        //        "donostia.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phoneNumber: "343-988834", image:
        //        "royaloak.jpg", isVisited: false,rating:"rating.jpg"),
        //    Restaurant(name: "Thai Cafe", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phoneNumber: "432-344050", image: "thaicafe.jpg", isVisited: false,rating:"rating.jpg")
 //   ]
}


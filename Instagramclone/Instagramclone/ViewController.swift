//
//  ViewController.swift
//  Instagramclone
//
//  Created by McKinney family  on 6/25/19.
//  Copyright © 2019 FasTek Technologies. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let q = PFQuery(className: "Bam")
        q.getObjectInBackground(withId: "ijLD5XpAl5") { (object, error) in
            if error != nil {
                print(error)
            } else {
                if let user = object {
                    user["WOW"] = "KK"
                    user.saveInBackground(block: { (sucess, error) in
                        if sucess {
                            print("save")
                            
                        } else {
                            print(error)
                        }
                    })
                    print(user)
                    print(user["wow"])
                }
            }
        }
        
        let testUser = PFObject(className: "Bam")
        
        testUser["WOW"] = "Money"
        
        testUser.saveInBackground { (success, error) in
            if success {
                print("User \(testUser) was saved ")
            } else {
                if error != nil {
                    print(error)
                }
            }
        }
        
        let testObject = PFObject(className: "TestObject2")
        
        testObject["foo"] = "bar"
        
        testObject.saveInBackground { (success, error) -> Void in
            
            // added test for success 11th July 2016
            
            if success {
                
                print("Object has been saved.")
                
            } else {
                
                if error != nil {
                    
                    print (error)
                    
                } else {
                    
                    print ("Error")
                }
                
            }
            
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    }





//
//  UserTableViewController.swift
//  Instagramclone
//
//  Created by McKinney family  on 6/30/19.
//  Copyright © 2019 FasTek Technologies. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {

    var usernamesArray = [String]()
    var userIDS = [String]()
    var isFollowing = ["" : true]
    
    var refesher: UIRefreshControl!
    
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "loginVC", sender: self)
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @objc func refesh(){
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            if error != nil {
                print(error)
                
            }else if let users = objects {
                self.usernamesArray.removeAll()
                self.userIDS.removeAll()
                self.isFollowing.removeAll()
                for object in users {
                    if let user = object as? PFUser {
                        
                        if user.objectId != PFUser.current()?.objectId {
                            
                            
                            
                            
                            
                            let usernames = user.username!.components(separatedBy: "@")
                            self.userIDS.append(user.objectId!)
                            
                            
                            self.usernamesArray.append(usernames[0])
                            
                            let query = PFQuery(className: "Followers")
                            
                            query.whereKey("follower", equalTo: PFUser.current()?.objectId)
                            query.whereKey("following", equalTo: user.objectId)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                if let objects = objects {
                                    if objects.count > 0 {
                                        self.isFollowing[user.objectId!] = true
                                        
                                    } else {
                                        self.isFollowing[user.objectId!] = false
                                    }
                                    
                                    if self.isFollowing.count == self.usernamesArray.count {
                                        self.tableView.reloadData()
                                        self.refesher.endRefreshing()
                                    }
                                }
                            })
                        }
                    }
                    
                }
                //self.tableView.reloadData()
            }
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       refesh()
        refesher = UIRefreshControl()
        refesher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refesher.addTarget(self, action: #selector(UserTableViewController.refesh), for: UIControl.Event.valueChanged)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernamesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = usernamesArray[indexPath.row]
        
        if isFollowing[userIDS[indexPath.row]]! {
            cell.accessoryType = .checkmark
            
        }
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if isFollowing[userIDS[indexPath.row]]! {
            
            isFollowing[userIDS[indexPath.row]] = false
            
            cell?.accessoryType = .none
            let query = PFQuery(className: "Followers")
            query.whereKey("follower", equalTo: PFUser.current()?.objectId!)
            query.whereKey("following", equalTo: userIDS[indexPath.row])
            
            query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    for object in objects {
                        object.deleteInBackground()
                    }
                }
            }
            
        } else {
            isFollowing[userIDS[indexPath.row]] = true
        
        
            cell?.accessoryType = .checkmark
        
            let following = PFObject(className: "Followers")
        
            following["follower"] = PFUser.current()?.objectId
            following["following"] = userIDS[indexPath.row]
            following.saveInBackground()
            
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



//
//  PostVC.swift
//  Instagramclone
//
//  Created by McKinney family  on 6/30/19.
//  Copyright © 2019 FasTek Technologies. All rights reserved.
//

import UIKit
import Parse

class PostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBOutlet weak var messageTextfield: UITextField!
    
    func createAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func chooseImgBtnPressed(_ sender: Any){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageToPost.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    @IBAction func postImgBtnPressed(_ sender: Any){
        
        let post = PFObject(className: "Posts")
        
        post["message"] = messageTextfield.text
        post["userid"] = PFUser.current()?.objectId!
        
        let imageData = imageToPost.image!.pngData()
        
        let imageFile = PFFileObject(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            if error != nil {
                self.createAlert(title: "Could not post image", message: "please try again later")
            } else {
                self.createAlert(title: "image Posted", message: "Your image has been posted successfully")
                
                self.messageTextfield.text = " "
                self.imageToPost.image = UIImage(named: "Image")
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

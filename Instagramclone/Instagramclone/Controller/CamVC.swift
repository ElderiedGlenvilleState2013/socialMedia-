//
//  CamVC.swift
//  Instagramclone
//
//  Created by McKinney family  on 6/29/19.
//  Copyright © 2019 FasTek Technologies. All rights reserved.
//

import UIKit

class CamVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var imagePicker = UIImagePickerController()
    @IBOutlet weak var img: UIImageView!
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let ig = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
            img.image = ig
        } else {
            print("there a problem")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnPressed(_ sender: Any){
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
        
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

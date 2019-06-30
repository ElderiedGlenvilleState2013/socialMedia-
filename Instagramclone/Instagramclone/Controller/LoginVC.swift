//
//  LoginVC.swift
//  Instagramclone
//
//  Created by McKinney family  on 6/29/19.
//  Copyright © 2019 FasTek Technologies. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {
    
    
    var signupMode = true
    
    var activityInd = UIActivityIndicatorView()
    
    

    @IBOutlet weak var userTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var signupOrLoginBtn:UIButton!
    @IBOutlet weak var changeSignupModeBtn:UIButton!
    
    @IBOutlet weak var messageLbl: UILabel!
    
    //create alert func
    
    func createAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func signupOrLoginBtnPressed(_ sender: Any){
        //print(signupMode)
        
        if userTextfield.text == "" || passwordTextfield.text == "" {
            
            createAlert(title: "error in form", message: "Please enter a username and password")
            
                    } else {
            
            activityInd = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityInd.center = self.view.center
            activityInd.hidesWhenStopped = true
            activityInd.style = UIActivityIndicatorView.Style.gray
            activityInd.startAnimating()
            view.addSubview(activityInd)
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                let user = PFUser()
                
                user.username = userTextfield.text
                user.email = userTextfield.text
                
                user.password = passwordTextfield.text
                
                user.signUpInBackground { (success, error) in
                    
                    self.activityInd.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        
                        
                        var displayErrorMessage = "Please try again later"
                        if let errorMessage = error?.localizedDescription {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        print(error)
                        
                        //self.createAlert(title: "sign up error", message: displayErrorMessage)
                        
                    }else {
                        print("user is signup")
                        self.performSegue(withIdentifier: "ShowUserTable", sender: self)
                    }
                }
            } else {
                //login mode
                
                PFUser.logInWithUsername(inBackground: userTextfield.text!, password: passwordTextfield.text!) {
                    (user, error) in
                    
                    self.activityInd.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later"
                        if let errorMessage = error?.localizedDescription {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        self.createAlert(title: "login error", message:displayErrorMessage )
                        
                    } else {
                        print("logged in")
                        
                        self.performSegue(withIdentifier: "ShowUserTable", sender: self)
                    }
                }
            }
        }
        
    }
    
    @IBAction func changeSignupModeBtnPressed(_ sender: Any){
        
        if signupMode {
            
            // change to login mode
            signupOrLoginBtn.setTitle("Login", for: [])
            changeSignupModeBtn.setTitle("Sign Up", for: [])
            
            messageLbl.text = "Don't have an account? "
            
            signupMode = false
            
        } else {
            
            signupOrLoginBtn.setTitle("Sign Up", for: [])
            
            changeSignupModeBtn.setTitle("Login", for: [])
            
            messageLbl.text = "Already have an account"
            
            signupMode = true
        }
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            //navigationController!.title = "\(PFUser.current())"
            self.performSegue(withIdentifier: "ShowUserTable", sender: self)
        }
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

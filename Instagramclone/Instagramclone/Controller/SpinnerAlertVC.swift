//
//  SpinnerAlertVC.swift
//  Instagramclone
//
//  Created by McKinney family  on 6/29/19.
//  Copyright © 2019 FasTek Technologies. All rights reserved.
//

import UIKit

class SpinnerAlertVC: UIViewController {

    var activityInd = UIActivityIndicatorView()
    
    
    
    
    
    @IBAction func createAlertBtnPressed(_ sender: Any){
        
        let alertC = UIAlertController(title: "Hey there", message: "Are you sure", preferredStyle: UIAlertController.Style.alert)
        
        alertC.addAction(UIAlertAction.init(title: "Okat", style: .default, handler: { (action) in
            print("okay button pressed")
            
            self.dismiss(animated: true, completion: nil)
            
            
        }))
        
        alertC.addAction(UIAlertAction.init(title: "no", style: .cancel , handler: { (action) in
            print("no button was pressed")
        }))
        
        self.present(alertC, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func pauseAppBtnPressed(_ sender: Any){
        activityInd = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityInd.center = self.view.center
        
        activityInd.hidesWhenStopped = true
        
        activityInd.style = UIActivityIndicatorView.Style.gray
        
        view.addSubview(activityInd)
        
        activityInd.startAnimating()
        
        //UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    
    @IBAction func restoreAppPressed(_ sender: Any){
        activityInd.stopAnimating()
       // UIApplication.shared.endIgnoringInteractionEvents()
        
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

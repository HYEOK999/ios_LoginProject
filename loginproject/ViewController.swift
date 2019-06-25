//
//  ViewController.swift
//  loginproject
//
//  Created by HYEOKBOOK on 26/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func googleBtn(_ sender: Any) {
    }
    
    @IBAction func facebookBtn(_ sender: Any) {
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
            if error != nil{
                AlertService.alertService(msg: error!.localizedDescription, vc: self)
            }
            else if result!.isCancelled{
                return
            }
            guard let accessToken = AccessToken.current else {
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential, completion: { (result, error) in
                if error != nil{
                    AlertService.alertService(msg: error!.localizedDescription, vc: self)
                    return
                }else{
                    (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
                }
            })
        }
    }
}


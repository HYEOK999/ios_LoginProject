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
import GoogleSignIn
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func googleBtn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
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
            
            SVProgressHUD.show()
            Auth.auth().signIn(with: credential, completion: { (result, error) in
                if error != nil{
                    AlertService.alertService(msg: error!.localizedDescription, vc: self)
                    SVProgressHUD.dismiss()

                    return
                }else{
                    (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
                    SVProgressHUD.dismiss()
                }
            })
        }
    }
}

extension ViewController : GIDSignInUIDelegate, GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            AlertService.alertService(msg: error.localizedDescription, vc: self)
            return
        }
        
        guard let authentication = user.authentication else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (result, error) in
            if error != nil{
                AlertService.alertService(msg: error!.localizedDescription, vc: self)
                return
            }
            else{
                (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
            }
        }
    }
}

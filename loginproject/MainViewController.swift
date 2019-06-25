//
//  MainViewController.swift
//  loginproject
//
//  Created by HYEOKBOOK on 26/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: Any) {
        AuthService.SignOut(onSuccess: {
            (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
            return
        }) { (error) in
            AlertService.alertService(msg: error!, vc: self)
        }
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

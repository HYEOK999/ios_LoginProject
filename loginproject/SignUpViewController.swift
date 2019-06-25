//
//  SignUpViewController.swift
//  loginproject
//
//  Created by HYEOKBOOK on 26/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var sexTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pictureBtn(_ sender: Any) {
        
    }
    
     @IBAction func signUp(_ sender: Any) {
        if emailTF.text == "" || passwordTF.text == "" || nameTF.text == "" || sexTF.text  == "" || ageTF.text  == "" {
            AlertService.alertService(msg: "빈칸이 존재합니다.", vc: self)
        }
        else{
            
        }
     }
}

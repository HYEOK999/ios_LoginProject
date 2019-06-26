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
    
    var selectedImg : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pictureBtn(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
     @IBAction func signUp(_ sender: Any) {
        if emailTF.text == "" || passwordTF.text == "" || nameTF.text == "" || sexTF.text  == "" || ageTF.text  == "" {
            AlertService.alertService(msg: "빈칸이 존재합니다.", vc: self)
        }
        else{
            if let profileImg = selectedImg, let imgData = profileImg.jpegData(compressionQuality: 0.1){
                AuthService
                    .SignUp(
                        imgData:imgData,
                        email: emailTF.text!,
                        password: passwordTF.text!,
                        name: nameTF.text!,
                        age: ageTF.text!,
                        sex: sexTF.text!,
                        onSuccess: {
                (UIApplication.shared.delegate as! AppDelegate).configualInitialVC()
                return
            }) { (error) in
                AlertService.alertService(msg: error!, vc: self)
                }
            }
        }
     }
}

extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            selectedImg = image
            imageVw.image = selectedImg
        }
        dismiss(animated: true, completion: nil)
    }
}

//
//  AuthService.swift
//  loginproject
//
//  Created by HYEOKBOOK on 26/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD
import GoogleSignIn
import FirebaseStorage

class AuthService{
    static func SignIn(email:String, password:String, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void ){
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                onError(error?.localizedDescription)
                return
            }
            else{
                SVProgressHUD.dismiss()
                onSuccess()
            }
        }
    }
    
    
    static func SignUp(imgData:Data, email:String, password:String, name:String, age:String, sex:String, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void){
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                onError(error?.localizedDescription)
                return
            }
            else{
                let uid = result!.user.uid
                let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid)
                storageRef.putData(imgData, metadata: nil, completion: { (_, error) in
                    if error != nil{
                        return
                    }
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil{
                            return
                        }
                        if let profileImageURL = url?.absoluteString{
                            self.setUsers(profileImg: profileImageURL, uid: uid, email: email, name: name, sex: sex, age: age, onSuccess: {
                                onSuccess()
                                SVProgressHUD.dismiss()
                            })
                        }
                    })
                })
            }
        }
    }
    
    
    static func SignOut(onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void){
        let firebaseAuth = Auth.auth()
        do {
            if let providerData = Auth.auth().currentUser?.providerData{
                let userInfo = providerData[0]
                switch userInfo.providerID{
                    case "google.com" : GIDSignIn.sharedInstance()?.signOut()
                    default : break
                }
            }
            try firebaseAuth.signOut()
            onSuccess()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            onError(signOutError.localizedDescription)
        }
    }
    
    
    static func FindPw(email:String, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void){
        SVProgressHUD.show()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil{
                SVProgressHUD.dismiss()
                onError(error?.localizedDescription)
                return
            }
            else{
                SVProgressHUD.dismiss()
                onSuccess()
            }
        }
    }
    
    static func setUsers(profileImg:String, uid:String, email:String, name:String, sex:String, age:String, onSuccess:@escaping() -> Void){
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        let newUsersRef = userRef.child(uid)
        newUsersRef.setValue([
            "Profile Image" : profileImg,
            "E-mail" : email,
            "Name" : name,
            "Name-lowcase" : name.lowercased(),
            "Sex" : sex,
            "Age" : age
            ])
        onSuccess()
    }
}

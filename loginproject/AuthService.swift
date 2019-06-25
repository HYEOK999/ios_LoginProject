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

class AuthService{
    static func SignIn(email:String, password:String, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void ){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                onError(error?.localizedDescription)
                return
            }
            else{
                onSuccess()
            }
        }
    }
    
    
    static func SignUp(email:String, password:String, name:String, age:String, sex:String, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil{
                onError(error?.localizedDescription)
                return
            }
            else{
                let uid = result?.user.uid
                setUsers(uid: uid!, email: email, name: name, sex: sex, age: age, onSuccess: {
                    onSuccess()
                })
            }
        }
    }
    
    
    static func SignOut(onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            onSuccess()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            onError(signOutError.localizedDescription)
        }
    }
    
    
    static func FindPw(email:String, onSuccess:@escaping () -> Void, onError:@escaping (_ errorMessage:String?) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil{
                onError(error?.localizedDescription)
                return
            }
            else{
                onSuccess()
            }
        }
    }
    
    static func setUsers(uid:String, email:String, name:String, sex:String, age:String, onSuccess:@escaping() -> Void){
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        let newUsersRef = userRef.child(uid)
        newUsersRef.setValue([
            "E-mail" : email,
            "Name" : name,
            "Name-lowcase" : name.lowercased(),
            "Sex" : sex,
            "Age" : age
            ])
        onSuccess()
    }
}

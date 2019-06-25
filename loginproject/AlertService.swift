//
//  AlertService.swift
//  loginproject
//
//  Created by HYEOKBOOK on 26/06/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import Foundation
import UIKit

class AlertService{
    static func alertService(msg:String, vc:UIViewController){
        let alertVC = UIAlertController(title: "경고", message: msg, preferredStyle: .actionSheet)
        let okBtn = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alertVC.addAction(okBtn)
        vc.present(alertVC, animated: true, completion: nil)
    }
}

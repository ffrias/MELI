//
//  MLPaymentInfoModel.swift
//  meliChallenge
//
//  Created by Federico Frias on 5/3/16.
//  Copyright © 2016 Ffrias. All rights reserved.
//

import Foundation

class MLPaymentInfoModel {
    //Screen 1
    var monto: Int
    //Screen 2
    var mp_id: String
    var mp_name: String
    //Screen 3
    var banco_id: String
    var banco_name: String
    //Screen 4
    var cuotas: String
    
    static let sharedInstance = MLPaymentInfoModel()
    
    private init(){
        monto = 0
        mp_id = ""
        mp_name = ""
        banco_id = ""
        banco_name = ""
        cuotas = ""
    }
    
}
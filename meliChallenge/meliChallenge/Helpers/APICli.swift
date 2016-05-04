//
//  APICli.swift
//  meliChallenge
//
//  Created by Federico Frias on 5/3/16.
//  Copyright © 2016 Ffrias. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class APICli{
    
    static let sharedInstance = APICli()
    private init(){}
    
    func getDataMercadolibre(base_url:String, urn:String, params:[String:String],completion:(result:JSON)->Void){
        
        Alamofire.request(.GET, base_url+urn, parameters: params)
            .validate()
            .responseJSON { response in
                        switch response.result {
                        case .Success:
                            if let data = response.result.value {
                            let json = JSON(data)
                            completion(result:json)
                            }
                        case .Failure(let error):
                            completion(result: JSON("Error: \(error)"))
                        }
        }
    }
}
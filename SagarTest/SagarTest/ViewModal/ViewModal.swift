//
//  ViewModal.swift
//  SagarTest
//
//  Created by Apple on 12/01/20.
//  Copyright © 2020 Macmini. All rights reserved.
//

import Foundation

class ViewModal {
    
        
        func getData(_ completion: @escaping ((Bool,JSONDictionary?,EBabuError?) -> ())) {
            APIController.makeRequestReturnJSON(.batman) { (data,statuscode,error) in
                if data != nil {
                    APIController.validateJason("\(statuscode)", completion: { (bool) in
                        if bool {
                            completion(bool, data, error)
                        }else{
                            completion(bool, data, error)
                        }
                    })
                }else{
                    completion(false,nil, error)
                }
            }
        }
}

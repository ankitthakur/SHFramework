//
//  SHINetworkParams.swift
//  SHFramework
//
//  Created by Ankit Thakur on 14/06/14.
//  Copyright (c) 2014 Ankit Thakur. All rights reserved.
//

import Foundation

class SHNetworkParams: NSObject {
    
    /**
    *  nsurlconnection object
    */
    var connection:NSURLConnection!;
    /**
    *  request, for which the connection is made
    */
    var request:NSMutableURLRequest!;
    /**
    *  success block, when the server status is SUCCESS/200
    */
    var completionBlock:CompletionBlock?;
    /**
    *  error block, when the server status is not SUCCESS/200
    */
    var errorBlock:ErrorBlock?;
    /**
    *  responseData is binary data, when status is SUCCESS/200
    */
    var responseData:NSMutableData!;
    
    /**
    * initialize method
    */
    init() {
        
    }
}

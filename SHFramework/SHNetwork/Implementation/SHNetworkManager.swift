//
//  SHNetworkManager.swift
//  SHFramework
//
//  Created by Ankit Thakur on 10/06/14.
//  Copyright (c) 2014 Ankit Thakur. All rights reserved.
//

import Foundation

class SHNetworkManager: NSObject , NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    var networkParams:NSMutableArray!;
    @required init() {
        networkParams = NSMutableArray();
    }
    
    class func isNetworkAvailable()->Bool{
        
        //        var reachability:Reachability;
        //        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        //        if ([reachability currentReachabilityStatus] == NotReachable) {
        //            return false;
        //        }
        return true;
    }
    
    func createAndStartConnectionWithRequest(urlRequest: NSMutableURLRequest!, onCompletion completionBlock: CompletionBlock!, onError errorBlock: ErrorBlock!){
        
        if(SHNetworkManager.isNetworkAvailable()){
            if (nil == networkParams) {
                networkParams = NSMutableArray();
            }
            
            var param:SHNetworkParams = SHNetworkParams();
            
            param.request = urlRequest;
            param.completionBlock = completionBlock;
            param.errorBlock = errorBlock;
            
            var connection:NSURLConnection = NSURLConnection(request: urlRequest, delegate: self);
            param.connection = connection;
            
            networkParams.addObject(param);
            
            connection.start();
        }
        else{
            if (errorBlock != nil) {
                var error:NSError = NSError.errorWithDomain("Network Error", code: 111, userInfo: ["localizedDescription":"Sorry, Some network error occurred"]);
                errorBlock!(error: error);
            }
        }
    }
    
    ///////////////////////////////////////////////////
    //////////   NSURLConnectionDelegate   ////////////
    ///////////////////////////////////////////////////
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!){
        
        var predicate:NSPredicate = NSPredicate(format: "connection=%@", connection);
        var params:NSArray = networkParams.filteredArrayUsingPredicate(predicate)
        
        if let param : SHNetworkParams = params.lastObject as? SHNetworkParams {
            if (param.errorBlock != nil) {
                var error:NSError = NSError.errorWithDomain("Network Error", code: 111, userInfo: ["localizedDescription":"Sorry, Some network error occurred"]);
                param.errorBlock!(error: error);
            }
        }
    }
    
    func connection(connection: NSURLConnection!, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge!){
        
    }
    
    func connection(connection: NSURLConnection!, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace!) -> Bool{
        
        var canAuthenticate:Bool = false;
        
        canAuthenticate = (protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust);
        
        return canAuthenticate;
        
    }
    
    func connection(connection: NSURLConnection!, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge!){
        
        var credential:NSURLCredential = NSURLCredential(trust:challenge.protectionSpace.serverTrust);
        challenge.sender.useCredential(credential, forAuthenticationChallenge: challenge);
        
    }
    
    ///////////////////////////////////////////////////////
    //////////   NSURLConnectionDataDelegate   ////////////
    ///////////////////////////////////////////////////////
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        
        var predicate:NSPredicate = NSPredicate(format: "connection=%@", connection);
        var params:NSArray = networkParams.filteredArrayUsingPredicate(predicate)
        
        var param : SHNetworkParams? = params.lastObject as? SHNetworkParams;
        if param != nil {
            
            var indexOfParam:Int = networkParams.indexOfObject(param);
            
            if (param!.responseData.length > 0) {
                param!.responseData.appendData(data);
            }
            else{
                param!.responseData = NSMutableData(data: data);
            }
            networkParams.replaceObjectAtIndex(indexOfParam, withObject: param);
        }
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        
        var predicate:NSPredicate = NSPredicate(format: "connection=%@", connection);
        var params:NSArray = networkParams.filteredArrayUsingPredicate(predicate)
        
        
        if var param : SHNetworkParams = params.lastObject as? SHNetworkParams{
            
            if (param.completionBlock != nil) {
                param.completionBlock!(responseData: param.responseData);
            }
        }
        
        
    }
}

//
//  cnam.swift
//  iCNAM
//
//  Created by Corey Edwards on 8/13/15.
//  Copyright (c) 2015 Corey Edwards. All rights reserved.
//

import Foundation

/* Set testing API creds. This will change in the working version to pull creds from CoreData store.

These credentials are EveryoneAPI testing creds only and will not work on actual requests. */
let account_sid = "AC2877277cd21a44af8e9344c53bb1311";
let auth_token = "AUe03f0c1796c04eed8d838061895b4534";

// This is the magic sauce - the API call
func query(phoneNumber: String) {

    var api : EveryoneAPI = EveryoneAPI(accountSID: account_sid, withAuthToken: auth_token)
    
    var errorHandler: EveryoneAPIErrorHandler = { readableError in print(readableError) }
    var successHandler: EveryoneAPISuccessHandler = { response in print(response.cnam) }
    
    api.getInformation(EveryoneAPIReturnData.CNAM, forPhoneNumber: "2532171703", withSuccessHandler: successHandler, withErrorHandler: errorHandler)
    

    //EveryoneAPI.getInformation(phoneNumber: phoneNumber, withSuccessHandler, withErrorHandler)
    
    /* EveryoneAPI *everyoneAPI = [[EveryoneAPI alloc] initWithAccountSID:@"accountSID" withAuthToken:@"authToken"];
    [everyoneAPI getInformation:EveryoneAPIReturnAllInfo forPhoneNumber:@"5551234567" withSuccessHandler:^(EveryoneAPIResponseObject *responseObject){
    //Success handler here
    } withErrorHandler:^(NSError *error, NSNumber *statusCode, NSString *readableError){
    //Error handler here
    }]; */
    
}
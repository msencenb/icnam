//
//  EveryoneAPI.h
//  Pods
//
//  Created by Matt Sencenbaugh on 1/21/15.
//
//
#import <Foundation/Foundation.h>
#import "EveryoneAPIResponseObject.h"

// Block callbacks for the API methods
typedef void (^EveryoneAPISuccessHandler)(EveryoneAPIResponseObject *response);
typedef void (^EveryoneAPIErrorHandler)(NSError *error, NSNumber *statusCode, NSString *readableError);

// Enum/Mask for specifying which data to get from the EveryoneAPI
// Currently does not support original carrier or location (although those are included in carrier and address respectively)
typedef NS_OPTIONS(NSUInteger, EveryoneAPIReturnData) {
    EveryoneAPIReturnName     = (1 << 0),  // => 00000001
    EveryoneAPIReturnCNAM     = (1 << 1),  // => 00000010
    EveryoneAPIReturnGender   = (1 << 2),  // => 00000100
    EveryoneAPIReturnImage    = (1 << 3),  // => 00001000
    EveryoneAPIReturnAddress  = (1 << 4),  // => 00010000
    EveryoneAPIReturnCarrier  = (1 << 5),  // => 00100000
    EveryoneAPIReturnLinetype = (1 << 6),  // => 01000000
    EveryoneAPIReturnAllInfo  = (1 << 7)   // => 10000000
};


@interface EveryoneAPI : NSObject

-(id)initWithAccountSID:(NSString *)accountSID withAuthToken:(NSString *)authToken;

-(void)getInformation:(EveryoneAPIReturnData)information forPhoneNumber:(NSString *)phoneNumber withSuccessHandler:(EveryoneAPISuccessHandler)successHandler withErrorHandler:(EveryoneAPIErrorHandler)errorHandler;

@end

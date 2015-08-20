//
//  EveryoneAPIResponseObject.h
//  Pods
//
//  Created by Matt Sencenbaugh on 1/24/15.
//
//

#import <Foundation/Foundation.h>

@interface EveryoneAPIResponseObject : NSObject

-(id)initWithDictionary:(NSDictionary *)dictionary;

// Use this if the property you want isn't exposed, or if the API updates and I haven't updated the cocoapod
@property(nonatomic, strong) NSDictionary *fullResponseDictionary;

// Shortcuts to specific data fields returned by EveryoneAPI
// ---------------------------------------------------------

// Carrier Info
@property(nonatomic, copy) NSString *carrierName;
@property(nonatomic, copy) NSString *originalCarrierName;
@property(nonatomic, copy) NSString *cnam;
@property(nonatomic, copy) NSString *linetype;

// Personal Info
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *gender;
@property(nonatomic, copy) NSString *coverImageURL;
@property(nonatomic, copy) NSString *largeImageURL;
@property(nonatomic, copy) NSString *mediumImageURL;
@property(nonatomic, copy) NSString *smallImageURL;

// Address and Location
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *state;
@property(nonatomic, copy) NSNumber *zipCode;
@property(nonatomic, copy) NSNumber *latitude;
@property(nonatomic, copy) NSNumber *longitude;

// Pricing info
@property(nonatomic, copy) NSNumber *totalSpent;

// Extra info
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *note;

@end

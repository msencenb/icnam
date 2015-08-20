//
//  EveryoneAPIResponseObject.m
//  Pods
//
//  Created by Matt Sencenbaugh on 1/24/15.
//
//

#import "EveryoneAPIResponseObject.h"

@implementation EveryoneAPIResponseObject

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        //Do init
        [self setupDataAttributes:[dictionary objectForKey:@"data"]];
        [self setupPricingAttributes:[dictionary objectForKey:@"pricing"]];
        self.fullResponseDictionary = dictionary;
        self.type = [dictionary objectForKey:@"type"];
        self.note = [dictionary objectForKey:@"note"];
    }
    return self;
}

-(void)setupDataAttributes:(NSDictionary *)dictionary
{
    NSDictionary *carrier = [dictionary objectForKey:@"carrier"];
    if (carrier) {
        self.carrierName = [carrier objectForKey:@"name"];
    }
    
    NSDictionary *originalCarrier = [dictionary objectForKey:@"carrier_o"];
    if (originalCarrier) {
        self.originalCarrierName = [originalCarrier objectForKey:@"name"];
    }
    
    self.linetype = [dictionary objectForKey:@"linetype"];
    self.cnam = [dictionary objectForKey:@"cnam"];
    
    self.name = [dictionary objectForKey:@"name"];
    self.gender = [dictionary objectForKey:@"gender"];
    NSDictionary *images = [dictionary objectForKey:@"image"];
    if (images) {
        self.coverImageURL = [images objectForKey:@"cover"];
        self.largeImageURL = [images objectForKey:@"large"];
        self.mediumImageURL = [images objectForKey:@"med"];
        self.smallImageURL = [images objectForKey:@"small"];
    }
    
    self.address = [dictionary objectForKey:@"address"];
    NSDictionary *location = [dictionary objectForKey:@"location"];
    if (location) {
        self.city = [location objectForKey:@"city"];
        self.state = [location objectForKey:@"state"];
        self.zipCode = [self numberForString:[location objectForKey:@"zip"]];
        NSDictionary *geo = [location objectForKey:@"geo"];
        if (geo) {
            self.latitude = [self numberForString:[geo objectForKey:@"latitude"]];
            self.longitude = [self numberForString:[geo objectForKey:@"longitude"]];
        }
    }
}

// TODO get more granular with pricing
-(void)setupPricingAttributes:(NSDictionary *)dictionary
{
    self.totalSpent = [self numberForString:[dictionary objectForKey:@"total"]];
}

#pragma mark - Helper methods
-(NSNumber *)numberForString:(NSString *)string
{
    if (string) {
        return [NSNumber numberWithDouble:string.doubleValue];
    } else {
        return nil;
    }
}

@end

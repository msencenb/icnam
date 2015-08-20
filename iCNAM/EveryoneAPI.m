//
//  EveryoneAPI.m
//  Pods
//
//  Created by Matt Sencenbaugh on 1/21/15.
//
//

#import "EveryoneAPI.h"
@interface EveryoneAPI ()
@property(nonatomic,copy) NSString *accountSID;
@property(nonatomic,copy) NSString *authToken;
@end

@implementation EveryoneAPI

-(id)initWithAccountSID:(NSString *)accountSID withAuthToken:(NSString *)authToken
{
    self = [super init];
    if (self) {
        self.accountSID = accountSID;
        self.authToken = authToken;
    }
    return self;
}

-(void)getInformation:(EveryoneAPIReturnData)information forPhoneNumber:(NSString *)phoneNumber withSuccessHandler:(EveryoneAPISuccessHandler)successHandler withErrorHandler:(EveryoneAPIErrorHandler)errorHandler
{
    NSString *infoRequested = [self stringFromInfoRequested:information];
    //if nil queryString is nothing
    NSString *accountInfo = [NSString stringWithFormat:@"account_sid=%@&auth_token=%@", self.accountSID, self.authToken];
    NSString *query = infoRequested ? [NSString stringWithFormat:@"data=%@&%@", infoRequested, accountInfo] : accountInfo;
    //TODO clean up on phone number?
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.everyoneapi.com/v1/phone/+1%@?%@", phoneNumber,query]];
    NSLog(@"%@",[url absoluteString]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        // Deal with connection errors
        if (error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                errorHandler(error, [NSNumber numberWithInt:-1], error.localizedDescription);
                return;
            });
        }
        
        // Handle response errors
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        if (urlResponse.statusCode != 200) {
            NSString *readableError = [self getReadableErrorFromURLResponse:urlResponse];
            NSNumber *numberStatuscode = [NSNumber numberWithInteger:urlResponse.statusCode];
            dispatch_sync(dispatch_get_main_queue(), ^{
                errorHandler(nil,numberStatuscode,readableError);
            });
            return;
        }
        
        // Actually parse the json
        NSError *parseError = nil;
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (parseError) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                errorHandler(parseError, [NSNumber numberWithInt:-1], parseError.localizedDescription);
            });
            return;
        }
        
        EveryoneAPIResponseObject *responseObject = [[EveryoneAPIResponseObject alloc] initWithDictionary:responseJSON];
        dispatch_sync(dispatch_get_main_queue(), ^{
            successHandler(responseObject);
        });
        
    }];
    [task resume];
}

-(NSString *)stringFromInfoRequested:(EveryoneAPIReturnData)information
{
    // If all the info is requested we don't need to specify which data to return to us
    if ((information & EveryoneAPIReturnAllInfo) == EveryoneAPIReturnAllInfo) {
        return nil;
    }
    
    // Since not all is requested, build the query string to send to everyoneAPI
    NSMutableArray *dataRequested = [NSMutableArray array];
    if ((information & EveryoneAPIReturnName) == EveryoneAPIReturnName) {
        [dataRequested addObject:@"name"];
    }
    if ((information & EveryoneAPIReturnCNAM) == EveryoneAPIReturnCNAM) {
        [dataRequested addObject:@"CNAM"];
    }
    if ((information & EveryoneAPIReturnGender) == EveryoneAPIReturnGender) {
        [dataRequested addObject:@"gender"];
    }
    if ((information & EveryoneAPIReturnImage) == EveryoneAPIReturnImage) {
        [dataRequested addObject:@"image"];
    }
    if ((information & EveryoneAPIReturnAddress) == EveryoneAPIReturnAddress) {
        [dataRequested addObject:@"address"];
    }
    if ((information & EveryoneAPIReturnCarrier) == EveryoneAPIReturnCarrier) {
        [dataRequested addObject:@"carrier"];
    }
    if ((information & EveryoneAPIReturnLinetype) == EveryoneAPIReturnLinetype) {
        [dataRequested addObject:@"linetype"];
    }
    return [dataRequested componentsJoinedByString:@","];
}

-(NSString *)getReadableErrorFromURLResponse:(NSHTTPURLResponse *)urlResponse
{
    NSString *readableError = nil;
    switch (urlResponse.statusCode) {
        case 400:
            readableError = @"The phone number entered is invalid. Ensure you have correctly entered a 10 digit US based phone number and excluded the country code.";
            break;
            
        case 401:
            readableError = @"You are unauthorized to view this information, please check your account SID and authorization token.";
            break;
            
        case 402:
            readableError = @"You don't have enough money in your account for this query. Please add more money to your EveryoneAPI account.";
            break;
            
        case 403:
            readableError = @"You've been rate limited for possible malicious activity.";
            break;
        case 404:
            readableError = @"There is no information currently available for the phone number entered";
            break;
            
        default:
            readableError = @"Sorry something went wrong";
            break;
    }
    return readableError;
}

@end
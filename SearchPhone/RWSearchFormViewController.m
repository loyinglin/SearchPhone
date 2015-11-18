//
//  RWSearchFormViewController.m
//  TwitterInstant
//
//  Created by Colin Eberhardt on 02/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWSearchFormViewController.h"
#import "RWSearchResultsViewController.h"
#import "LYPhone.h"

#import <ReactiveCocoa.h>

typedef NS_ENUM(NSInteger, LYSearchPhoneError) {
    LYSearchPhoneErrorPhoneError,
    LYSearchPhoneErrorAPIError
};

@interface RWSearchFormViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (strong, nonatomic) RWSearchResultsViewController *resultsViewController;

@end

@implementation RWSearchFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Twitter Instant";
    
    [self styleTextField:self.searchText];
    
    self.resultsViewController = self.splitViewController.viewControllers[1];
    
    @weakify(self)
    
    [[[[[self.searchText.rac_textSignal
     filter:^BOOL(NSString* text) {
        return text.length == 11;
     }]
     throttle:0.5]
     flattenMap:^RACStream *(NSString* text) {
         @strongify(self)
         return [self signalForSearchPhoneWithText:text];
     }]
     deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(NSDictionary* dict) {
         LYPhone* phone = [LYPhone initWithDict:dict];
         [self.resultsViewController viewInitWithDict:phone];
     }
     error:^(NSError *error) {
         NSLog(@"error %@", error);
     }];
}

- (void)styleTextField:(UITextField *)textField {
    CALayer *textFieldLayer = textField.layer;
    textFieldLayer.borderColor = [UIColor grayColor].CGColor;
    textFieldLayer.borderWidth = 2.0f;
    textFieldLayer.cornerRadius = 0.0f;
}

- (RACSignal*)signalForSearchPhoneWithText:(NSString*)text {
    NSError* phoneError = [NSError errorWithDomain:@"LYERROR" code:LYSearchPhoneErrorPhoneError userInfo:nil];
    NSError* apiError = [NSError errorWithDomain:@"LYERROR" code:LYSearchPhoneErrorAPIError userInfo:nil];
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        if (text.length != 11) {
            [subscriber sendError:phoneError];
        }
        
        NSString *httpUrl = @"http://apis.baidu.com/apistore/mobilenumber/mobilenumber";
        NSString *httpArg = [NSString stringWithFormat:@"phone=%@", text];
        
        NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
        NSURL *url = [NSURL URLWithString: urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        [request addValue: @"d233f5dfd98c24f5d9e595af6e5c9fac" forHTTPHeaderField: @"apikey"];
        [NSURLConnection sendAsynchronousRequest: request
                                           queue: [NSOperationQueue mainQueue]
                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (error) {
                                       [subscriber sendError:apiError];
                                   } else {
                                       NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                       if (responseCode == 200) {
                                           NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                           NSNumber* errNum = [dict objectForKey:@"errNum"];
                                           if ([errNum integerValue] == 0) {
                                               
                                               [subscriber sendNext:[dict objectForKey:@"retData"]];
//                                               [subscriber sendCompleted];

                                           }
                                           
                                           else {
                                               [subscriber sendError:apiError];
                                           }
                                       
                                       }
                                       else{
                                           [subscriber sendError:apiError];
                                       }
                                   }
                               }];

        return nil;
    }];
}


@end

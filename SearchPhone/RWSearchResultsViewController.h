//
//  RWSearchResultsViewController.h
//  TwitterInstant
//
//  Created by Colin Eberhardt on 03/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYPhone.h"

@interface RWSearchResultsViewController : UIViewController

@property (nonatomic , strong) IBOutlet UILabel*    myPhoneNum;
@property (nonatomic , strong) IBOutlet UILabel*    mySupllier;
@property (nonatomic , strong) IBOutlet UILabel*    myProvince;
@property (nonatomic , strong) IBOutlet UILabel*    myCity;

- (void)viewInitWithDict:(LYPhone*)detail;

@end

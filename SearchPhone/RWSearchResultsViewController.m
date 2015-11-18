//
//  RWSearchResultsViewController.m
//  TwitterInstant
//
//  Created by Colin Eberhardt on 03/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//


#import "RWSearchResultsViewController.h"

@interface RWSearchResultsViewController ()

@property (nonatomic, strong) NSArray *tweets;
@end

@implementation RWSearchResultsViewController {

}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.tweets = [NSArray array];
  
}

- (void)viewInitWithDict:(LYPhone *)detail{
    self.myPhoneNum.text = [NSString stringWithFormat:@"手机号码：%@", detail.phone];
    self.mySupllier.text = [NSString stringWithFormat:@"服务商：%@", detail.supplier];
    self.myProvince.text = [NSString stringWithFormat:@"省份：%@", detail.province];
    self.myCity.text = [NSString stringWithFormat:@"城市：%@", detail.city];
}

@end

//
//  LYPhone.m
//  SearchPhone
//
//  Created by 林伟池 on 15/11/18.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "LYPhone.h"

@implementation LYPhone

+(instancetype)initWithDict:(NSDictionary *)dict{
    LYPhone* ret = [LYPhone new];
    ret.phone = [dict objectForKey:@"phone"];
    ret.supplier = [dict objectForKey:@"supplier"];
    ret.province = [dict objectForKey:@"province"];
    ret.city = [dict objectForKey:@"city"];
    
    return ret;
}

@end

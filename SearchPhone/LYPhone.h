//
//  LYPhone.h
//  SearchPhone
//
//  Created by 林伟池 on 15/11/18.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYPhone : NSObject

@property (nonatomic , strong) NSString* phone;
@property (nonatomic , strong) NSString* supplier;
@property (nonatomic , strong) NSString* province;
@property (nonatomic , strong) NSString* city;

+(instancetype)initWithDict:(NSDictionary*)dict;

@end

//
//  CFCityModel.m
//  CityManagerUI
//
//  Created by   颜风 on 14-6-18.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFCityModel.h"


/*一个测试类*/
@interface City : NSObject
@property (retain, nonatomic) NSString * name;//!< 城市名称.
@property (retain, nonatomic) NSArray * area; //!< 城市行政区域.
@property (retain, nonatomic) City * city;
- (instancetype) initWithName: (NSString *) name
                     withArea: (NSArray *) area;
@end
@implementation City
-(void)dealloc
{
    self.name = nil;
    self.area = nil;
    
    [super dealloc];
}
- (instancetype) initWithName: (NSString *) name
                     withArea: (NSArray *) area
{
    if (self = [super init]) {
        self.name = name;
        self.area = area;
        self.city = self;
    }
    
    return self;
}
@end

@interface CFCityModel ()
@property (retain, nonatomic, readwrite) NSArray * originalData; //!< 原始数据.
@end

@implementation CFCityModel

#pragma mark - 实例方法.
-(void)dealloc
{
    self.originalData = nil;
    
    [super dealloc];
}

- (instancetype) init
{
    if (self = [super init]) {
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        
        NSArray * originalData = [[NSArray alloc] initWithContentsOfFile: filePath];
        
        self.originalData = originalData;
        [originalData release];
    }
    
    return self;
}

- (NSArray *) infoOfChina
{
    NSMutableArray * result = [[NSMutableArray alloc] initWithCapacity:self.originalData.count];
    
    result = [self.originalData valueForKey: @"name"];
    
    return result;
}

- (NSArray *) infoOfProvince: (NSString *) province;
{
    NSArray * result;
    
    result = [self.originalData filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == %@", province]];
    
    if (0 == result.count) {
        return nil;
    }

    result = [result[0] valueForKeyPath:@"info.name"];
    
    return result;
}

- (NSArray *) infoOfCith: (NSString *) city
                province: (NSString *) province
{
    // 获取指定省的信息.
    NSArray * result;
    
    result = [self.originalData filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == %@", province]];
    
    if (0 == result.count) {
        return nil;
    }
    
    // 获取指定市的信息.
    result = [result[0] valueForKeyPath:@"info"];
    
    result = [result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == %@", city]];
    
    if (0 == result.count) {
        return nil;
    }

    result = [result[0] valueForKeyPath:@"info.name"];
    
    return result;
}

@end

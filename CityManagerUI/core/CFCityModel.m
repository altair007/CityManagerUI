//
//  CFCityModel.m
//  CityManagerUI
//
//  Created by   颜风 on 14-6-18.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFCityModel.h"

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
    
    [self.originalData enumerateObjectsUsingBlock:^(NSDictionary  * obj, NSUInteger idx, BOOL *stop) {
        // 获取省名.
        NSString * name = [obj objectForKey: @"name"];
        [result addObject: name];
    }];
    
    return result;
}

- (NSArray *) infoOfProvince: (NSString *) province;
{
    NSMutableArray * result = [[NSMutableArray alloc] initWithCapacity: 42];
    
    [self.originalData enumerateObjectsUsingBlock:^(NSDictionary  * infoOfProvince, NSUInteger idx, BOOL *stop) {
        // 获取省名.
        NSString * nameOfProvince = [infoOfProvince objectForKey: @"name"];
        
        if ([nameOfProvince isEqualToString: province]) { // 找到省.
            // 获取城市信息.
            NSArray * infoOfCities = [infoOfProvince objectForKey: @"info"];
            
            // 遍历获取所有城市名称.
            [infoOfCities enumerateObjectsUsingBlock:^(NSDictionary * infoOfCity, NSUInteger idx, BOOL *stop) {
                // 获取城市名称
                NSString * nameOfCity = [infoOfCity objectForKey: @"name"];
                [result addObject: nameOfCity];
            }];
            
            *stop = YES;
        }
    }];
    
    return result;
}

- (NSArray *) infoOfCith: (NSString *) city
{
    NSMutableArray * result = [[NSMutableArray alloc] initWithCapacity: 42];
    
    // ???:三重遍历,总觉得可以简化下!要么是重组数据源,要么是改变遍历搜索算法.
    // ???:使用KVC简化语法.
    [self.originalData enumerateObjectsUsingBlock:^(NSDictionary  * infoOfProvince, NSUInteger idx, BOOL *stopFirst) {
        // 获取各市信息.
        NSArray * infoOfCities = [infoOfProvince objectForKey: @"info"];
        [infoOfCities enumerateObjectsUsingBlock:^(NSDictionary * infoOfCity, NSUInteger idx, BOOL *stopSencond) {
            // 获取城市名称.
            NSString * nameOfCity = [infoOfCity objectForKey: @"name"];
            
            if ([nameOfCity isEqualToString: city]) { // 找到目标.
                // 获取区县信息.
                NSArray * infoOfAreas = [infoOfCity objectForKey: @"info"];
                
                // 遍历获取所有城市名称.
                [infoOfAreas enumerateObjectsUsingBlock:^(NSDictionary * area, NSUInteger idx, BOOL *stopThird) {
                    // 获取区县名称.
                    NSString * nameOfArea = [area objectForKey: @"name"];
                    
                    [result addObject: nameOfArea];
                }];
                
                * stopFirst = YES;
                * stopSencond = YES;
            }
            
        }];
    }];
    
    return result;
}

@end

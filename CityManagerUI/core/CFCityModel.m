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
    
    result = [result objectAtIndex: 0];
    
    result = [result valueForKeyPath:@"info.name"];
    
    return result;
}

- (NSArray *) infoOfCith: (NSString *) city
{
    NSArray * result;
    
    result = [self.originalData valueForKeyPath:@"info.info"];
    
    //???:  必须用block结合谓词过滤了! 总觉得可以通过某种方式简化!
    result = [result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == %@", city]];
    
    if (0 == result.count) {
        return nil;
    }
    
    result = [result objectAtIndex: 0];

    
    result = [result valueForKeyPath:@"info.name"];
    
    return result;
    
    
//    NSMutableArray * result = [[NSMutableArray alloc] initWithCapacity: 42];
//    
//    // ???:使用一个类存储城市信息:国家:省:市.
//    
//    // ???:三重遍历,总觉得可以简化下!要么是重组数据源,要么是改变遍历搜索算法.
//    // ???:使用KVC简化语法.
//    [self.originalData enumerateObjectsUsingBlock:^(NSDictionary  * infoOfProvince, NSUInteger idx, BOOL *stopFirst) {
//        // 获取各市信息.
//        NSArray * infoOfCities = [infoOfProvince objectForKey: @"info"];
//        [infoOfCities enumerateObjectsUsingBlock:^(NSDictionary * infoOfCity, NSUInteger idx, BOOL *stopSencond) {
//            // 获取城市名称.
//            NSString * nameOfCity = [infoOfCity objectForKey: @"name"];
//            
//            if ([nameOfCity isEqualToString: city]) { // 找到目标.
//                // 获取区县信息.
//                NSArray * infoOfAreas = [infoOfCity objectForKey: @"info"];
//                
//                // 遍历获取所有城市名称.
//                [infoOfAreas enumerateObjectsUsingBlock:^(NSDictionary * area, NSUInteger idx, BOOL *stopThird) {
//                    // 获取区县名称.
//                    NSString * nameOfArea = [area objectForKey: @"name"];
//                    
//                    [result addObject: nameOfArea];
//                }];
//                
//                * stopFirst = YES;
//                * stopSencond = YES;
//            }
//            
//        }];
//    }];
//    
//    return result;
}

@end

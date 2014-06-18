//
//  CFMainController.m
//  CityManagerUI
//
//  Created by   颜风 on 14-6-18.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFMainController.h"
#import "CFCityModel.h"
#import "CFCityViewController.h"

@implementation CFMainController
#pragma mark - 单例
static CFMainController * sharedObj = nil;
+ (instancetype) sharedInstance
{
    if (nil == sharedObj) {
        [[self alloc] init];
    }
    
    return sharedObj;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    if (nil == sharedObj) {
        sharedObj = [super allocWithZone:zone];
        return sharedObj;
    }
    
    return nil;
}

- (instancetype) copyWithZone: (NSZone *) zone
{
    return  self;
}

- (instancetype)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return UINT_MAX;
}

- (oneway void)release
{
    
}

- (instancetype) autorelease
{
    return self;
}

#pragma mark - 实例方法
- (void)dealloc
{
    self.countryVC = nil;
    self.provinceVC = nil;
    self.cityVC = nil;
    
    [super dealloc];
}

- (instancetype) init
{
    if (self = [super init]) {
        
        CFCityViewController * countryVC = [[CFCityViewController alloc] initWithLevel:COUNTRY];
        countryVC.title = @"中国";
        self.countryVC = countryVC;
        [countryVC release];
        
        CFCityViewController * provinceVC = [[CFCityViewController alloc] initWithLevel:PROVIENCE];
        self.provinceVC = provinceVC;
        [provinceVC release];
        
        CFCityViewController * cityVC = [[CFCityViewController alloc] initWithLevel:CITY];
        self.cityVC = cityVC;
        [cityVC release];
        
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:self.countryVC];
        self.navController = nav;
        [nav release];
        
        CFCityModel * model = [[CFCityModel alloc] init];
        self.model = model;
        [model release];
    }
    
    return  self;
}

- (void)setModel:(CFCityModel *)model
{
    [model retain];
    [_model release];
    _model = model;
    
    self.countryVC.infoOfCities = [self infoOfChina];
}

- (NSArray *) infoOfChina
{
    NSArray * info = [self.model infoOfChina];
    
    return info;
}

- (NSArray *) infoOfProvince: (NSString *) province;
{
    NSArray * info = [self.model infoOfProvince: province];
    
    return info;
}

- (NSArray *) infoOfCity: (NSString *) city
                province: (NSString *) province
{
    NSArray * info = [self.model infoOfCith: city province: province];
    
    return info;
}

- (void) switchToInfoViewOfProvince: (NSString *) province
{
    self.provinceVC.infoOfCities = [self infoOfProvince: province];
    self.provinceVC.title = province;
    
    if (YES == [self.navController.viewControllers containsObject: self.provinceVC]) {
        [self.navController popToViewController:self.provinceVC animated: YES];
    }
    
    [self.navController pushViewController:self.provinceVC animated:YES];
}

- (void) switchToInfoViewOfCity:(NSString *) city
                       province: (NSString *) province
{
    self.cityVC.infoOfCities = [self infoOfCity: city province: province];
    self.cityVC.title = city;
    
    if (YES == [self.navController.viewControllers containsObject: self.cityVC]) {
        [self.navController popToViewController:self.cityVC animated: YES];
    }
    

    
    [self.navController pushViewController:self.cityVC animated:YES];
}

@end

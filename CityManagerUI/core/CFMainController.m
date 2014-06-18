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
{
    NSArray * info = [self.model infoOfCith: city];
    
    return info;
}

// ???:看一下云姐demo.据说返回时,会崩!
// !!!:更新文件夹.
- (void) switchToInfoViewOfProvince: (NSString *) province
{
    self.provinceVC.infoOfCities = [self infoOfProvince: province];
    
    if (nil == self.provinceVC.navigationItem.leftBarButtonItem &&
        self.provinceVC != self.navController.viewControllers[0]) { // 添加返回按钮.
        UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
        self.provinceVC.navigationItem.leftBarButtonItem = backBarButtonItem;
        [backBarButtonItem release];
    }
    
    if (YES == [self.navController.viewControllers containsObject: self.provinceVC]) {
        [self.navController popToViewController:self.provinceVC animated: YES];
    }
    
    [self.navController pushViewController:self.provinceVC animated:YES];
}

- (void) switchToInfoViewOfCity:(NSString *) city
{
    self.cityVC.infoOfCities = [self infoOfCity: city];
    
    
    if (nil == self.cityVC.navigationItem.leftBarButtonItem &&
        self.cityVC != self.navController.viewControllers[0]) {  // 添加返回按钮.
        UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
        self.cityVC.navigationItem.leftBarButtonItem = backBarButtonItem;
        [backBarButtonItem release];
    }
    
    if (YES == [self.navController.viewControllers containsObject: self.cityVC]) {
        [self.navController popToViewController:self.cityVC animated: YES];
    }
    

    
    [self.navController pushViewController:self.cityVC animated:YES];
}

- (void) didClickBackButtonItemAction: (UIBarButtonItem *) buttonItem
{
    [self.navController popViewControllerAnimated:YES];
}

@end

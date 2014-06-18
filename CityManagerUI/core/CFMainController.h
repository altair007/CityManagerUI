//
//  CFMainController.h
//  CityManagerUI
//
//  Created by   颜风 on 14-6-18.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CFCityModel;
@class CFCityViewController;

/**
 *  主控制器
 */
@interface CFMainController : NSObject
@property (retain, nonatomic) CFCityModel * model; //!< 城市信息数据模型.
@property (retain, nonatomic) UINavigationController * navController; //!< 导航栏控制器.
@property (retain, nonatomic) CFCityViewController * countryVC; //!< 国家城市信息控制器.
@property (retain, nonatomic) CFCityViewController * provinceVC; //!< 省城市信息控制器.
@property (retain, nonatomic) CFCityViewController * cityVC; //!< 市城市信息控制器

/**
 *  获取单例.
 *
 *  @return 单例.
 */
+ (instancetype) sharedInstance;

/**
 *  获取中国各省的信息.
 *
 *  @return 中国各省的信息.
 */
- (NSArray *) infoOfChina;

/**
 *  获取某个省各个市的信息.
 *
 *  @param province 省名.
 *
 *  @return 某个省各个市的信息.
 */
- (NSArray *) infoOfProvince: (NSString *) province;

/**
 *  获取某个市的区县信息.
 *
 *  @param city 市名.
 *
 *  @return 某个市的区县信息.
 */
- (NSArray *) infoOfCity: (NSString *) city;

/**
 *  转向中国的城市信息页.
 */
- (void) switchToInfoViewOfChina;

/**
 *  转向某省的城市信息页.
 *
 *  @param province 省名.
 */
- (void) switchToInfoViewOfProvince: (NSString *) province;

/**
 * 转向某市的区县信息页.
 *
 *  @param city 市名.
 */
- (void) switchToInfoViewOfCity:(NSString *) city;

@end

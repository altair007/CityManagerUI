//
//  CFCityModel.h
//  CityManagerUI
//
//  Created by   颜风 on 14-6-18.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  城市信息数据模型
 */
@interface CFCityModel : NSObject
@property (retain, nonatomic, readonly) NSArray * originalData; //!< 原始数据.

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
- (NSArray *) infoOfCith: (NSString *) city;

@end

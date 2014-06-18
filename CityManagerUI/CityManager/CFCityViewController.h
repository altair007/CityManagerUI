//
//  CFCityViewController.h
//  CityManagerUI
//
//  Created by   颜风 on 14-6-18.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFCityView.h"

/**
 *  用于显示哪个级别的城市信息.
 */
typedef enum : NSUInteger {
    COUNTRY,
    PROVIENCE,
    CITY
} CFInfoLevel;

/**
 *  城市信息控制器.
 */
@interface CFCityViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) CFCityView * view; //!< 重声明超类视图.
@property (retain, nonatomic) NSArray * infoOfCities; //!< 城市信息.
@property (assign, nonatomic) CFInfoLevel  level; //!< 信息级别.

/**
 *  便利初始化.
 *
 *  @param level 信息级别.
 *
 *  @return 初始化后的对象.
 */
- (instancetype) initWithLevel: (CFInfoLevel) level;

/**
 *  获取某分区某行的城市信息.
 *
 *  @param indexPath 指定分区和行.
 *
 *  @return 某分区某行的城市信息.
 */
- (NSString *) infoAtIndexPath: (NSIndexPath *)indexPath;

@end

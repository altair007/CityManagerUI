//
//  CFCityViewController.m
//  CityManagerUI
//
//  Created by   颜风 on 14-6-18.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFCityViewController.h"
#import "CFCityView.h"
#import "CFMainController.h"

@interface CFCityViewController ()

@end

@implementation CFCityViewController 
#pragma mark - 实例方法
- (void)dealloc
{
    self.infoOfCities = nil;
    
    [super dealloc];
}

- (instancetype) initWithLevel:(CFInfoLevel)level
{
    if (self = [super init]) {
        self.level = level;
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    CFCityView * view = [[CFCityView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    view.delegate = self;
    view.dataSource = self;
    
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) infoAtIndexPath: (NSIndexPath *)indexPath
{
    NSString * info = [self.infoOfCities objectAtIndex: indexPath.row];
    
    return info;
}

- (void)setInfoOfCities:(NSArray *)infoOfCities
{
    [infoOfCities retain];
    [_infoOfCities release];
    _infoOfCities = infoOfCities;
    
    [self.view reloadData];
}

# pragma mark - UITableViewDataSource协议方法.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = self.infoOfCities.count;
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identify = @"city";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
    }
    
    cell.textLabel.text = [self infoAtIndexPath: indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate 协议方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取主控制器
    CFMainController * sharedInstance = [CFMainController sharedInstance];
    
    // 获取被选中行的信息.
    NSString * info = [self infoAtIndexPath: indexPath];
    
    switch (self.level) {
        case COUNTRY:
            [sharedInstance switchToInfoViewOfProvince: info];
            break;
            
        case PROVIENCE:
            [sharedInstance switchToInfoViewOfCity: info];
            break;
        
        default:
            break;
    }
}

@end

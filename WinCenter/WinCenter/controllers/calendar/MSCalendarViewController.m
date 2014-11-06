//
//  MSCalendarViewController.m
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2013 Monospace Ltd. All rights reserved.
//

#import "MSCalendarViewController.h"
#import "MSCollectionViewCalendarLayout.h"
#import "MSEvent.h"
#import "MSGridline.h"
#import "MSTimeRowHeaderBackground.h"
#import "MSDayColumnHeaderBackground.h"
#import "MSEventCell.h"
#import "MSDayColumnHeader.h"
#import "MSTimeRowHeader.h"
#import "MSCurrentTimeIndicator.h"
#import "MSCurrentTimeGridline.h"

NSString * const MSEventCellReuseIdentifier = @"MSEventCellReuseIdentifier";
NSString * const MSDayColumnHeaderReuseIdentifier = @"MSDayColumnHeaderReuseIdentifier";
NSString * const MSTimeRowHeaderReuseIdentifier = @"MSTimeRowHeaderReuseIdentifier";

@interface MSCalendarViewController () <MSCollectionViewDelegateCalendarLayout>

@property NSMutableDictionary *dataList;
@property (nonatomic, strong) MSCollectionViewCalendarLayout *collectionViewCalendarLayout;

@end

@implementation MSCalendarViewController

- (id)init
{
    self.collectionViewCalendarLayout = [[MSCollectionViewCalendarLayout alloc] init];
    self.collectionViewCalendarLayout.delegate = self;
    self = [super initWithCollectionViewLayout:self.collectionViewCalendarLayout];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.dataList = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSMutableArray *arr;
    arr = [NSMutableArray new];

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    
    MSEvent *event;
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-20 02:00:00"];
    event.title = @"李克强访粮农组织总部 回忆吃不饱饭岁月";
    event.location = @"location";
    [arr addObject:event];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-20 13:00:00"];
    event.title = @"最年轻院士李宁担纲国家百亿级课题 捞钱手段曝光";
    event.location = @"location";
    [arr addObject:event];
    
    [self.dataList setObject:arr forKey:@"2015-02-20"];
    
    arr = [NSMutableArray new];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-21 04:00:00"];
    event.title = @"郑州嫌犯遭围捕驾车连撞6车 在警方鸣枪中逃脱";
    event.location = @"location";
    [arr addObject:event];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-21 10:00:00"];
    event.title = @"title";
    event.location = @"location";
    [arr addObject:event];
    
    [self.dataList setObject:arr forKey:@"2015-02-21"];
    
    arr = [NSMutableArray new];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-22 06:00:00"];
    event.title = @"韩国海警宣布严打中国渔民 邀记者观摩打击(图)";
    event.location = @"location";
    [arr addObject:event];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-22 09:00:00"];
    event.title = @"局地大闸蟹因反腐价格降四成 官员消费几乎为零";
    event.location = @"location";
    [arr addObject:event];
    
    [self.dataList setObject:arr forKey:@"2015-02-22"];
    
    
    arr = [NSMutableArray new];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-23 14:00:00"];
    event.title = @"韩国小伙为逃避兵役故意注射阳萎药物";
    event.location = @"location";
    [arr addObject:event];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-23 07:00:00"];
    event.title = @"title";
    event.location = @"location";
    [arr addObject:event];
    
    [self.dataList setObject:arr forKey:@"2015-02-23"];
    
    arr = [NSMutableArray new];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-24 23:00:00"];
    event.title = @"朝鲜内阁设宴犒劳跳马冠军 家属参加宴会";
    event.location = @"location";
    [arr addObject:event];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-24 11:00:00"];
    event.title = @"中石油纪检组长王立新被调查 官网个人信息被删除";
    event.location = @"location";
    [arr addObject:event];
    
    [self.dataList setObject:arr forKey:@"2015-02-24"];
    
    arr = [NSMutableArray new];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-25 20:00:00"];
    event.title = @"陈卓林出事或涉利益输送 雅居乐拿地模式早已埋下隐患";
    event.location = @"location";
    [arr addObject:event];
    
    event = [MSEvent new];
    event.start = [formater dateFromString:@"2015-02-25 10:00:00"];
    event.title = @"title";
    event.location = @"location";
    [arr addObject:event];
    
    [self.dataList setObject:arr forKey:@"2015-02-25"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.directionalLockEnabled = YES;
    
    [self.collectionView registerClass:MSEventCell.class forCellWithReuseIdentifier:MSEventCellReuseIdentifier];
    [self.collectionView registerClass:MSDayColumnHeader.class forSupplementaryViewOfKind:MSCollectionElementKindDayColumnHeader withReuseIdentifier:MSDayColumnHeaderReuseIdentifier];
    [self.collectionView registerClass:MSTimeRowHeader.class forSupplementaryViewOfKind:MSCollectionElementKindTimeRowHeader withReuseIdentifier:MSTimeRowHeaderReuseIdentifier];
    
    // These are optional. If you don't want any of the decoration views, just don't register a class for them.
    [self.collectionViewCalendarLayout registerClass:MSCurrentTimeIndicator.class forDecorationViewOfKind:MSCollectionElementKindCurrentTimeIndicator];
    [self.collectionViewCalendarLayout registerClass:MSCurrentTimeGridline.class forDecorationViewOfKind:MSCollectionElementKindCurrentTimeHorizontalGridline];
    [self.collectionViewCalendarLayout registerClass:MSGridline.class forDecorationViewOfKind:MSCollectionElementKindVerticalGridline];
    [self.collectionViewCalendarLayout registerClass:MSGridline.class forDecorationViewOfKind:MSCollectionElementKindHorizontalGridline];
    [self.collectionViewCalendarLayout registerClass:MSTimeRowHeaderBackground.class forDecorationViewOfKind:MSCollectionElementKindTimeRowHeaderBackground];
    [self.collectionViewCalendarLayout registerClass:MSDayColumnHeaderBackground.class forDecorationViewOfKind:MSCollectionElementKindDayColumnHeaderBackground];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionViewCalendarLayout scrollCollectionViewToClosetSectionToCurrentTimeAnimated:NO];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // On iPhone, adjust width of sections on interface rotation. No necessary in horizontal layout (iPad)
    if (self.collectionViewCalendarLayout.sectionLayoutType == MSSectionLayoutTypeVerticalTile) {
        [self.collectionViewCalendarLayout invalidateLayoutCache];
        // These are the only widths that are defined by default. There are more that factor into the overall width.
        self.collectionViewCalendarLayout.sectionWidth = (CGRectGetWidth(self.collectionView.frame) - self.collectionViewCalendarLayout.timeRowHeaderWidth - self.collectionViewCalendarLayout.contentMargin.right);
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataList.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ((NSArray *)[self.dataList objectForKey:self.dataList.allKeys[section]]).count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MSEventCellReuseIdentifier forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    cell.event = ((NSArray *)[self.dataList objectForKey:self.dataList.allKeys[indexPath.section]])[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view;
    if (kind == MSCollectionElementKindDayColumnHeader) {
        MSDayColumnHeader *dayColumnHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MSDayColumnHeaderReuseIdentifier forIndexPath:indexPath];
        NSDate *day = [self.collectionViewCalendarLayout dateForDayColumnHeaderAtIndexPath:indexPath];
        NSDate *currentDay = [self currentTimeComponentsForCollectionView:self.collectionView layout:self.collectionViewCalendarLayout];
        dayColumnHeader.day = day;
        dayColumnHeader.currentDay = [[day beginningOfDay] isEqualToDate:[currentDay beginningOfDay]];
        view = dayColumnHeader;
    } else if (kind == MSCollectionElementKindTimeRowHeader) {
        MSTimeRowHeader *timeRowHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:MSTimeRowHeaderReuseIdentifier forIndexPath:indexPath];
        timeRowHeader.time = [self.collectionViewCalendarLayout dateForTimeRowHeaderAtIndexPath:indexPath];
        view = timeRowHeader;
    }
    return view;
}

#pragma mark - MSCollectionViewCalendarLayout

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout dayForSection:(NSInteger)section
{
    MSEvent *event = [((NSArray *)[self.dataList objectForKey:self.dataList.allKeys[section]]) firstObject];
    return event.day;
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout startTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSEvent *event = ((NSArray *)[self.dataList objectForKey:self.dataList.allKeys[indexPath.section]])[indexPath.row];
    return event.start;
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout endTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSEvent *event = ((NSArray *)[self.dataList objectForKey:self.dataList.allKeys[indexPath.section]])[indexPath.row];
    return [event.start dateByAddingTimeInterval:(60 * 60 * 3)];
}

- (NSDate *)currentTimeComponentsForCollectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout
{
    return [NSDate date];
}

@end

//
//  ITTSegement.m
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "PoolDatagridSegement.h"

@implementation PoolDatagridSegement
{
    NSMutableArray *allItems;
    
}

-(id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        [self _initViews:items];
    }
    
    return self;
}

-(void)_initViews:(NSArray *)items
{
    
    allItems = [[NSMutableArray alloc] initWithCapacity:items.count];
    float itemWidth = [UIScreen mainScreen].bounds.size.width/items.count;
    self.items = items;
//    NSArray *upImages = @[@"up_red@2x.png", @"up_white@2x.png"];
//    NSArray *downImages = @[@"down_red@2x.png", @"down_white@2x.png"];
    
    for (int i = 0; i < items.count; i++) {
        NSString *itemName = items[i];

        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(i*itemWidth, 0, itemWidth, 35)];
        
        UILabel *titleLabel =[[UILabel alloc] initWithFrame:itemView.bounds];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = itemName;
        titleLabel.tag = 2013;
        [itemView addSubview:titleLabel];
        
        PoolDatagridArrow *arrowView = [[PoolDatagridArrow alloc] initWithFrame:CGRectMake(itemWidth-30, 10, 16, 16)];
        
        __weak PoolDatagridSegement *this = self;
        arrowView.block = ^(ArrowStates state){
            PoolDatagridSegement *strong = this;
            strong.currentState = state;
        };
        
        arrowView.tag = 2014;
        if (i == 0) {
            arrowView.isSelected = YES;
        }
        [itemView addSubview:arrowView];
        
        UIImageView *indexView = [[UIImageView alloc] initWithFrame:CGRectZero];
        indexView.image = [UIImage imageNamed:@"index.png"];
        [itemView addSubview:indexView];
        indexView.tag = 2015;
        
        [self addSubview:itemView];
        [allItems addObject:itemView];
    }
}

-(void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex = selectedIndex;
    float itemWidth = [UIScreen mainScreen].bounds.size.width/_items.count;
    
    for (int i = 0; i < allItems.count; i++) {
        UIView *itemView = allItems[i];
        UILabel *titleLabel = (UILabel *)[itemView viewWithTag:2013];
        PoolDatagridArrow *arrowView = (PoolDatagridArrow *)[itemView viewWithTag:2014];
        UIImageView *indexView = (UIImageView *)[itemView viewWithTag:2015];
        if (i == selectedIndex) {
            
            titleLabel.textColor = [UIColor redColor];
            arrowView.isSelected = YES;
            indexView.frame = CGRectMake(0, 37, itemWidth, 3);
            indexView.image = [UIImage imageNamed:@"index_press.png"];
        } else {
            titleLabel.textColor = [UIColor blackColor];
            arrowView.isSelected = NO;
            indexView.image = [UIImage imageNamed:@"index.png"];
            indexView.frame = CGRectMake(0, 39, itemWidth, 1);
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    float width = [UIScreen mainScreen].bounds.size.width/self.items.count;
    int index = point.x /width;
    self.selectedIndex = index;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}



@end


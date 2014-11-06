//
//  ViewController.m
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "PoolDatagridVC.h"
#import "PoolDatagridSegement.h"
#import "PoolDatagridModel.h"
#import "PoolDatagridCell.h"

@interface PoolDatagridVC (){
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PoolDatagridVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    data = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        int num1 = rand()%100 * i;
        int num2 = 100 - rand()%5 * i;
        int num3 = rand()%50;
        PoolDatagridModel *model = [[PoolDatagridModel alloc] init];
        model.number1 = num1;
        model.number2 = num2;
        model.number3 = num3;
        [data addObject:model];
    }
    
    NSArray *items = @[@"金额", @"利率", @"期限"];
    PoolDatagridSegement *segment = [[PoolDatagridSegement alloc] initWithItems:items];
    segment.frame = CGRectMake(0, 64, 320, 40);
    segment.backgroundColor = [UIColor whiteColor];
    segment.selectedIndex = 0;
    [segment addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segment];
}

-(void)sgAction:(PoolDatagridSegement *)sg
{
    NSLog(@"%d %d", sg.selectedIndex, sg.currentState);
    
    for (PoolDatagridModel *model in data) {
        if (sg.currentState == UPStates) {
            model.isUp = YES;
        } else {
            model.isUp = NO;
        }
    }
    
    if (sg.selectedIndex == 0) {
        data = [data sortedArrayUsingSelector:@selector(compareNum1:)];
    } else if (sg.selectedIndex == 1) {
        data = [data sortedArrayUsingSelector:@selector(compareNum2:)];
    } else {
        data = [data sortedArrayUsingSelector:@selector(compareNum3:)];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    PoolDatagridCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[PoolDatagridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    if(data.count==0) return cell;
    
    cell.model = data[indexPath.row];
    
    return cell;
}


@end

//
//  PoolCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmDashboardVC.h"
#import "VmContainerVC.h"
#import "VmDashboardCell.h"
#import "VmDashboardHeader.h"


@implementation VmDashboardVC

-(void)reloadData{
    [[RemoteObject getCurrentDatacenterVO] getVmListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:[RemoteObject getCurrentDatacenterVO].name];
        [self.collectionView reloadData];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VmDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmDashboardCell" forIndexPath:indexPath];
    
    VmVO *vmVO = (VmVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = vmVO.name;
    cell.label1.text = vmVO.ip;
    if(vmVO.ip == nil){
        cell.label1.text = @"(尚未配置ip)";
    }
    cell.label2.text = [NSString stringWithFormat:@"%d", vmVO.vcpu];
    cell.label3.text = [NSString stringWithFormat:@"%.2fGB", vmVO.memory/1024.0];
    cell.label4.text = [NSString stringWithFormat:@"%dGB", vmVO.storage];
    cell.status.text = [vmVO state_text];
    cell.status.textColor = [vmVO state_color];
    cell.osType_image.image = [UIImage imageNamed:[vmVO osType_imageName]];
    
    cell.progress_1.litEffect = NO;
    cell.progress_1.numBars = 10;
    cell.progress_1.value = [self formatCountData:vmVO.vcpu/(2*8*4.0)];;
    cell.progress_1.backgroundColor = [UIColor clearColor];
    cell.progress_1.outerBorderColor = [UIColor clearColor];
    cell.progress_1.innerBorderColor = [UIColor clearColor];
    
    cell.progress_2.litEffect = NO;
    cell.progress_2.numBars = 10;
    cell.progress_2.value = [self formatCountData:vmVO.memory/(1024.0*16.0)];;
    cell.progress_2.backgroundColor = [UIColor clearColor];
    cell.progress_2.outerBorderColor = [UIColor clearColor];
    cell.progress_2.innerBorderColor = [UIColor clearColor];
    
    cell.progress_3.litEffect = NO;
    cell.progress_3.numBars = 10;
    cell.progress_3.value = [self formatCountData:vmVO.storage/320.0];;
    cell.progress_3.backgroundColor = [UIColor clearColor];
    cell.progress_3.outerBorderColor = [UIColor clearColor];
    cell.progress_3.innerBorderColor = [UIColor clearColor];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    VmDashboardHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VmDashboardHeader" forIndexPath:indexPath];
    
    header.vmCount.text =[NSString stringWithFormat:@"%d",0];
    header.label1.text =[NSString stringWithFormat:@"%d",0];
    header.label2.text =[NSString stringWithFormat:@"%d",0];
    header.label3.text =[NSString stringWithFormat:@"%d",0];
    header.label4.text =[NSString stringWithFormat:@"%d",0];
    header.label5.text =[NSString stringWithFormat:@"%d",0];
    header.label6.text =[NSString stringWithFormat:@"%d",0];
    header.label7.text =[NSString stringWithFormat:@"%d",0];
    header.label8.text =[NSString stringWithFormat:@"%d",0];
    
    //缩起
    header.label10.text = [NSString stringWithFormat:@"%d",0];
    header.label11.text =[NSString stringWithFormat:@"%d",0];
    header.label12.text =[NSString stringWithFormat:@"%d",0];
    header.label13.text =[NSString stringWithFormat:@"%d",0];
    header.label14.text =[NSString stringWithFormat:@"%d",0];
    header.label15.text =[NSString stringWithFormat:@"%d",0];
    header.label16.text =[NSString stringWithFormat:@"%d",0];
    header.label17.text = [NSString stringWithFormat:@"%d",0];
    header.label18.text = [NSString stringWithFormat:@"%d",0];
    
    //圈图
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:header.vmOsTypeChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:50] andClockwise:YES andShadow:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
    [circleChart strokeChart];
    [header.vmOsTypeChart addSubview:circleChart];
    
    
    PNCircleChart * circleChart2 = [[PNCircleChart alloc] initWithFrame:header.vmStatusChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:50] andClockwise:YES andShadow:YES];
    circleChart2.backgroundColor = [UIColor clearColor];
    circleChart2.strokeColor = [UIColor clearColor];
    circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart2.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart2 strokeChart];
    [header.vmStatusChart addSubview:circleChart2];
    
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController *root = [[UIStoryboard storyboardWithName:@"VM" bundle:nil] instantiateInitialViewController];
    VmContainerVC *vc;
    if([root isKindOfClass:[VmContainerVC class]]){
        vc = (VmContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.vmVO = (VmVO *)[self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];

    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}


@end

//
//  ViewController.m
//  测试时间
//
//  Created by 孙亚锋 on 16/10/24.
//  Copyright © 2016年 孙亚锋. All rights reserved.
//
//  屏幕 —— 宽度
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
//  屏幕 —— 高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "Tool.h"
#import "XZHomeHuaiYunCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    
    UILabel *_titleLab;
    UIButton *_LeftButton;
    UIButton *_RightButton;
    int _currentDay;
    
    int index;
    int  dayaaa;
    
    
    UICollectionView *collectView;
     CGFloat begain;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 预产期
    NSString *yuChanQi = @"2017-07-30";

    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//转为东八区
    [fmt setTimeZone:zone];
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    [fmt setDateFormat:@"yyyy-MM-dd "];
    
    NSDate *yuChanQiDate = [fmt dateFromString:yuChanQi];
    
    //转为时间戳
    NSString *yuchanqi =  [NSString stringWithFormat:@"%ld",(long)[yuChanQiDate timeIntervalSince1970]];
    NSLog(@"预产期  %@",yuchanqi);
    
      NSDate *currentDat = [NSDate date];
    NSString *currentShiJianChuo  = [NSString stringWithFormat:@"%ld",(long)[currentDat timeIntervalSince1970]];
    
    NSLog(@"当前时间  %@",currentShiJianChuo);
    
  
    
    NSString *shijian = [NSString stringWithFormat:@"%lld",[yuchanqi longLongValue] - [currentShiJianChuo longLongValue]] ;
    
    NSLog(@"shijian  %lld",[shijian longLongValue]/60/60/24+1);
    // 一般怀孕时间为 280天  40周
      dayaaa = 280 - (int)([shijian longLongValue]/60/60/24 +1);
  
    NSLog(@"怀孕了多少天 %d",dayaaa);
    
    
    
    
    
//    280 －  （预产期时间 － 当前时间)获得的天数  就是怀孕的天数
    
    _currentDay  = (int)dayaaa;
    
     index = 0;
    
    
    
    [self setupTitle];
    
                        // 例如刚刚怀孕第一天                  //怀孕到 这里 左右点击
//                            当前怀孕天数
// ....39周6天      40周          0周1天          0周2天      .....39周6天        40周
//  2017/8/6     2017/8/7      2016/10/24      2016/10/25      2017/8/6     2017/8/7
                    //  --按钮 减到第40周的日期就变了,
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-64);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) collectionViewLayout:layout];
    collectView.showsHorizontalScrollIndicator = NO;
    collectView.backgroundColor = [UIColor colorWithRed:252/255.f green:152/255.f blue:195/255.f alpha:1];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.pagingEnabled = YES;
    [collectView registerClass:[XZHomeHuaiYunCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collectView];
    
    [collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentDay inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

-(void)setupTitle{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,130, 40)];
    
    view.backgroundColor = [UIColor darkGrayColor];
    _LeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_LeftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    
    _LeftButton.frame = CGRectMake(0,5,30,30);
    [_LeftButton addTarget:self action:@selector(leftTitleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:_LeftButton];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(35,5,70,30)];
    
    _titleLab.text = [self getDayWithCurrentDay:_currentDay];
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:_titleLab];
    
    
    
    _RightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_RightButton setImage:[UIImage imageNamed:@"右白箭头"] forState:UIControlStateNormal];
    
    _RightButton.frame = CGRectMake(105,5,30,30);
    [_RightButton addTarget:self action:@selector(rightTitleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_RightButton];
    self.navigationItem.titleView = view;
}
-(void)leftTitleButtonAction{
    
    index--;
    _currentDay --;
    
    if(_currentDay <= 0) {
    [collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentDay inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    _currentDay = 280;
    index = 280-dayaaa;
    }else{
         [collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentDay inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    // 设置 title
  _titleLab.text  =  [self getDayWithCurrentDay:_currentDay];
    
//  [collectView reloadData];

}
-(void)rightTitleButtonAction{
    
    index++;
    _currentDay ++;
    NSLog(@"~~~~~~~~~~~%d",_currentDay);
    if (_currentDay > 280) {
        [collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentDay inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        

        _currentDay = 1;
        
        index = -dayaaa+1;
    }else{
         [collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentDay inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
    // 设置标题
    _titleLab.text  =  [self getDayWithCurrentDay:_currentDay];
//    CGPoint point = collectView.contentOffset;
    
//    [collectView setContentOffset:CGPointMake(point.x + collectView.frame.size.width, 0) animated:YES];
    

    
}
-(NSString *)getDayWithCurrentDay:(int)currentDay{
    
    if (currentDay %7 == 0) {
        return  [NSString stringWithFormat:@"%d周",currentDay/7];
    }else{
        return [NSString stringWithFormat:@"%d周%d天",currentDay/7,currentDay%7];
    }
}


#pragma mark - --------------collectionView--------------
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 282;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZHomeHuaiYunCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    NSLog(@"~~~%d~~~%d",_currentDay,index);
    cell.indexDay = index;
    [cell setNeedsLayout];
    
    
    return cell;
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
     begain = scrollView.contentOffset.x/kScreenWidth;
}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    if (!decelerate) {
//        CGFloat offset = scrollView.contentOffset.x/kScreenWidth;
//        if (offset-begain>0) {
//            [self rightTitleButtonAction];
//        } else if (offset-begain<0) {
//            [self leftTitleButtonAction];
//        }
//    }
//    
//}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x/kScreenWidth;
    NSLog(@"~~~~~%f~~~~%f",offset,begain);
    if (offset-begain>0) {
        [self rightTitleButtonAction];
    } else if (offset-begain<0) {
        [self leftTitleButtonAction];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    Log(@"%f",scrollView.contentOffset);
    CGFloat offset = scrollView.contentOffset.x;
    if (offset == 0) {
        [collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:280 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    if (offset == scrollView.contentSize.width-scrollView.frame.size.width) {
        [collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

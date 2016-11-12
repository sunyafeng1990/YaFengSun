
//
//  XZHomeHuaiYunCollectionViewCell.m
//  XiaoZhu
//
//  Created by 孙亚锋 on 16/8/19.
//  Copyright © 2016年 孙亚锋. All rights reserved.
//
//  屏幕 —— 宽度
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
//  屏幕 —— 高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "XZHomeHuaiYunCollectionViewCell.h"
#import "Tool.h"
@interface XZHomeHuaiYunCollectionViewCell()<UITableViewDataSource,UITableViewDelegate>




@end


@implementation XZHomeHuaiYunCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
         _tableView= [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_tableView];
    }
    
    return self;
}

// 怀孕天数索引 set方法
-(void)setIndexDay:(int)indexDay{
   
    _indexDay = indexDay;
//    Log(@"indexDay  %d",indexDay);
//   _HuaiYunView.dateLab.text = [XZTool getDayWeek:indexDay];
    [self.tableView reloadData];
}
// 怀孕天数 set方法
//-(void)setCurrentedDay:(int)currentedDay{
//    
//    _currentedDay = currentedDay;
//   
//    
//    [self.tableView reloadData];
//}
#pragma mark - TableHeaderView
//  区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//  行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 10;
}
// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //怀孕
    
                
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changedCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"changedCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
      
    }
    cell.textLabel.text = @"怀孕时间";
    cell.textLabel.text = [Tool getDayWeek:self.indexDay];
    
    return cell;
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_tableView reloadData];
}








@end

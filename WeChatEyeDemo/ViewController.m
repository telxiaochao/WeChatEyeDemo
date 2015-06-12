//
//  ViewController.m
//  WeChatEyeDemo
//
//  Created by 58 on 15/6/10.
//  Copyright (c) 2015年 58. All rights reserved.
//

#import "ViewController.h"
#import "XCPathAnimationControl.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor grayColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    // 设置数据源
    _tableView.dataSource = self;
    // 设置代理
    _tableView.delegate = self;
    // 设置表视图cell的高度，统一的高度
    _tableView.rowHeight = 70;    // 默认44px
    // 设置表视图的背景
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0410"]];
    _tableView.backgroundView = backgroundView;
    
    // 设置表视图的颜色
    _tableView.backgroundColor = [UIColor blackColor];
    // 设置表视图的分割线的颜色
    _tableView.separatorColor = [UIColor purpleColor];
    // 设置表视图的分割线的风格
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 设置表视图的头部视图(headView 添加子视图)
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    headerView.backgroundColor = [UIColor redColor];
    // 添加子视图
    UILabel *headText = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 80)];
    headText.text = @"小超威武,小超威武威武威威武!";
    headText.numberOfLines = 0;
    [headerView addSubview:headText];
    
    _tableView.tableHeaderView = headerView; //设置头部
  
    // 设置表视图的尾部视图(footerView 添加子视图)
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    footerView.backgroundColor = [UIColor yellowColor];
    _tableView.tableFooterView = footerView;  //设置尾部  

    [self.view addSubview:_tableView];
    XCPathAnimationControl *refreshControl = [[XCPathAnimationControl alloc] init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshControlDidRefresh:) forControlEvents:UIControlEventValueChanged];
    
}
- (void)refreshControlDidRefresh:(UIRefreshControl *)sender
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [sender endRefreshing];
        
        
    });
    
}
//UITableView有多少个组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;//默认为1
}
//UITableView每组有多少条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 6;
}

//创建一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
        //cell的四种样式
        //UITableViewCellStyleDefault,       只显示图片和标题
        //UITableViewCellStyleValue1,        显示图片，标题和子标题（子标题在右边）
        //UITableViewCellStyleValue2,        标题和子标题
        //UITableViewCellStyleSubtitle       显示图片，标题和子标题（子标题在下边）
        
    }
    // 指向其中一行
    cell.textLabel.text =@"ViewController 有取贝塞尔取现坐标算法！！！";//设置cell的标题
    cell.textLabel.textColor = [UIColor redColor];//设置标题字体颜色
    cell.textLabel.font = [UIFont fontWithName:@"下拉出现眼睛" size:18];//设置标题字体大小
    

    return cell;
    
}

#warning 贝塞尔取现坐标取点方法
/**
 *  贝塞尔取现坐标取点方法
 *
 *  @param X0 坐标1
 *  @param X1 坐标2
 *  @param X2 坐标3
 *  @param t  时间  （0-1）
 *
 *  @return float
 */
-(float)catchX0:(float)X0 andX1:(float)X1 andX2:(float)X2 andT0:(float)t{
    
    float Number = 0;
    Number = (1 - t) * (1 - t) * X0 + 2 * t * (1 - t) * X1 + t * t * X2;
    return Number;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

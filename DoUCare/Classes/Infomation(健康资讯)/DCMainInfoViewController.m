//
//  DCMainInfoViewController.m
//  DoUCare
//
//  Created by soft on 15/10/20.
//  Copyright © 2015年 DemonChou. All rights reserved.
//

#import "DCMainInfoViewController.h"
#import "HACursor.h"
#import "UIView+Extension.h"
#import "DCInfoLIstModel.h"

@interface DCMainInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *allTitles;

@property(nonatomic,strong) NSArray *infoList;

@property (strong, nonatomic) UITableView *infoView;
@end

@implementation DCMainInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"classify" ofType:@"plist"];
    NSArray *plistArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *titles = [NSMutableArray new];
    for (NSDictionary *dict in plistArr) {
        NSString *title = dict[@"title"];
        [titles addObject:title];
    }
    self.allTitles = [titles copy];
    [self createHeadScrollView];
}

- (void)createHeadScrollView{

    HACursor *cursor = [[HACursor alloc]init];
    cursor.frame = CGRectMake(0, 64, self.view.width, 40);
    cursor.titles = self.allTitles;
    cursor.titles = @[@"企业"];
    cursor.pageViews = [self createPageViews];
    cursor.backgroundColor = [UIColor orangeColor];
    //设置根滚动视图的高度
    cursor.rootScrollViewHeight = self.view.frame.size.height - 104;
    
    //默认值是白色
    cursor.titleNormalColor = [UIColor whiteColor];
    //默认值是白色
    cursor.titleSelectedColor = [UIColor redColor];
    cursor.showSortbutton = NO;
    //默认的最小值是5，小于默认值的话按默认值设置
    cursor.minFontSize = 6;
    //默认的最大值是25，小于默认值的话按默认值设置，大于默认值按设置的值处理
    cursor.maxFontSize = 20;
    [self.view addSubview:cursor];
}

- (NSMutableArray *)createPageViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < self.allTitles.count; i++) {
        UITableView *infoView = [[UITableView alloc]init];
        infoView.delegate = self;
        infoView.dataSource = self;
        self.infoView = infoView;
        [self loadInfoViewWithID:(i + 1)];
        [pageViews addObject:self.infoView];
    }
    return pageViews;
}

- (void)loadInfoViewWithID:(NSInteger)ID {
    
    
    NSString *path = [NSString stringWithFormat:@"http://www.tngou.net/api/info/list?id=%ld&rows=10",ID];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *utf8Path = [path stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    
    NSURLSessionDataTask *task = [[NSURLSession  sharedSession]dataTaskWithURL:[NSURL URLWithString:utf8Path]completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        _infoList = [DCInfoLIstModel parse:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.infoView reloadData];
        });
    }];
    [task resume];
    

}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    
    if (self.infoList.count != 0) {
        DCInfoLIstModel *info = self.infoList[indexPath.row];
        cell.textLabel.text = info.title;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end

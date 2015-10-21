//
//  DCMainInfoViewController.m
//  DoUCare
//
//  Created by soft on 15/10/20.
//  Copyright © 2015年 DemonChou. All rights reserved.
//

#import "DCMainInfoViewController.h"
#import "DCInfoLIstModel.h"
#import "DCInfoListCell.h"
#import "UIImageView+WebCache.h"

@interface DCMainInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation DCMainInfoViewController

-(NSArray *)listArray{
    
    if (!_listArray) {
        _listArray = [[NSArray alloc]init];
    }
    return _listArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = @"http://www.tngou.net/api/info/list?id=3&rows=10";
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:path] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"tngou"];
        self.listArray = [DCInfoLIstModel parse:array];
        NSLog(@"已获取列表的网络信息");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.listTableView reloadData];
        });
        
    }];
    [task resume];
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    if (self.listArray.count != 0) {
        DCInfoLIstModel *infoList = self.listArray[indexPath.row];
        cell.title.text = infoList.title;
        cell.desc.text = infoList.desc;
        NSString *imagePath = [NSString stringWithFormat:@"http://tnfs.tngou.net/image%@_160x140",infoList.img];
        [cell.smallImage sd_setImageWithURL:[NSURL URLWithString:imagePath]];
    }
    
    return cell;
    
}
#pragma mark - UITableViewDelegate
//点击单元格 触发 storyBoard 中的跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self performSegueWithIdentifier:@"ListToDetail" sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end

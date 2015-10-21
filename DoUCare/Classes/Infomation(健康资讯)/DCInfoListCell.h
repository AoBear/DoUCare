//
//  DCInfoListCell.h
//  DoUCare
//
//  Created by soft on 15/10/21.
//  Copyright © 2015年 DemonChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCInfoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *smallImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end

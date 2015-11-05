//
//  CoffeeTableViewCell.h
//  期末考
//
//  Created by 鄭涵嚴 on 2015/11/5.
//  Copyright © 2015年 鄭涵嚴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *coffeeName;

@property (weak, nonatomic) IBOutlet UIImageView *coffeeImage;
@property (weak, nonatomic) IBOutlet UILabel *coffeeAddress;
@end

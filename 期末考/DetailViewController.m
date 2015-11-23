//
//  DetailViewController.m
//  期末考
//
//  Created by 鄭涵嚴 on 2015/11/5.
//  Copyright © 2015年 鄭涵嚴. All rights reserved.
//

#import "DetailViewController.h"
#import "AddressViewController.h"
#import "ImageViewController.h"
#import <Parse/Parse.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *webUrl;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property(strong,nonatomic)UIImage *photoPara;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.title = @"返回";
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    if (self.coffeeDic != nil) {
        self.name.text = _coffeeDic[@"name"];
        self.address.text = _coffeeDic[@"address"];
//        NSNumber *tmp =_coffeeDic[@"phone"];
        NSString *phoneString = [NSString stringWithFormat:@"%@" ,_coffeeDic[@"phone"]];
        self.phone.text = phoneString;
        self.webUrl.text = _coffeeDic[@"webUrl"];
        self.detail.text = _coffeeDic[@"detail"];
        NSData *photoImage = _coffeeDic[@"photo"];
        self.photo.image = [[UIImage alloc] initWithData:photoImage];
        self.photoPara = self.photo.image;
//        PFFile *photoImage = _coffeeDic[@"photo"];
//        NSNull *wrong = [NSNull null];
//        if (photoImage != wrong) {
//            [photoImage getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError *
//                                                  _Nullable error) {
//                if(error == nil) {
//                    self.photoPara  = [[UIImage alloc] initWithData:data];
//                    self.photo.image = self.photoPara;
//                }
//            }];
//    }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addressPress:(UITapGestureRecognizer *)sender {
    AddressViewController  *pushControl = [self.storyboard                                           instantiateViewControllerWithIdentifier:@"AddressViewController"];
    pushControl.address = self.address.text;
    [self presentViewController:pushControl animated:NO
                        completion:nil];
}
- (IBAction)phonePress:(UITapGestureRecognizer *)sender {
    BOOL result = [[UIApplication sharedApplication] openURL:
                   [NSURL URLWithString:self.phone.text]];
}
- (IBAction)webUrlPress:(UITapGestureRecognizer *)sender {
    BOOL result = [[UIApplication sharedApplication] openURL:
                   [NSURL URLWithString:self.webUrl.text]];

}
- (IBAction)imagePress:(UITapGestureRecognizer *)sender {
    if (self.photoPara != nil) {
        ImageViewController  *pushControl = [self.storyboard                                           instantiateViewControllerWithIdentifier:@"ImageViewController"];
        pushControl.photo = self.photoPara;
        [self presentViewController:pushControl animated:NO
                         completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

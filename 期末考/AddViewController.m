//
//  AddViewController.m
//  期末考
//
//  Created by 鄭涵嚴 on 2015/11/5.
//  Copyright © 2015年 鄭涵嚴. All rights reserved.
//

#import "AddViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "CoffeeShop.h"

@interface AddViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *webText;
@property (weak, nonatomic) IBOutlet UITextField *detailText;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectPhoto:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = true;
        [self presentViewController:picker animated:true completion:nil];
    }

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _photoImage.image = image;
    [self dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)save:(UIBarButtonItem *)sender {
    NSData *imageData = UIImagePNGRepresentation(self.photoImage.image);
    PFFile *imageFile;
    NSDictionary *dic;
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoffeeShop" inManagedObjectContext:delegate.managedObjectContext];
    CoffeeShop *record = [[CoffeeShop alloc] initWithEntity:entity insertIntoManagedObjectContext:delegate.managedObjectContext];
    record.name = self.nameText.text;
    record.address = self.addressText.text;
    NSNumber *tmp = [NSNumber numberWithInt:self.phoneText.text.intValue];
    record.phone = tmp;
    record.weburl = self.webText.text;
    record.detail = self.detailText.text;
    record.photo = imageData;
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (imageData!=nil) {
        imageFile = [PFFile fileWithName:@"image" data:imageData];
        dic =
        @{@"name":self.nameText.text,
          @"address":self.addressText.text,
          @"phone":self.phoneText.text,
          @"webUrl":self.webText.text,
          @"detail":self.detailText.text,
          @"photo":imageFile};
    }
    else{
        dic =
        @{@"name":self.nameText.text,
          @"address":self.addressText.text,
          @"phone":self.phoneText.text,
          @"webUrl":self.webText.text,
          @"detail":self.detailText.text,
          @"photo":[NSNull null]};
    };
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"AddCoffee" object:nil
     userInfo:dic];
    [self.navigationController
     popViewControllerAnimated:YES];

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

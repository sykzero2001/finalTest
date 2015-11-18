//
//  CoffeeTableViewController.m
//  期末考
//
//  Created by 鄭涵嚴 on 2015/11/5.
//  Copyright © 2015年 鄭涵嚴. All rights reserved.
//

#import "CoffeeTableViewController.h"
#import "CoffeeTableViewCell.h"
#import <Parse/Parse.h>
#import "DetailViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "AppDelegate.h"
#import "CoffeeShop.h"

@interface CoffeeTableViewController ()
{
    NSMutableArray *coffeeShopArray;
}
@end

@implementation CoffeeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    UINib *nib = [UINib nibWithNibName:@"CoffeeTableViewCell"
                                bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"coffeeCell"];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(addCoffeeNoti:)
     name:@"AddCoffee" object:nil];
    NSString *host = @"www.apple.com";
    SCNetworkReachabilityRef  reachability = SCNetworkReachabilityCreateWithName(nil,
                                                                                 host.UTF8String);
    SCNetworkReachabilityFlags flags;
    BOOL result = NO;
    if(reachability) {
        result = SCNetworkReachabilityGetFlags(reachability, &flags);
        CFRelease(reachability);
    };
    if(!result || !flags) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"網路障礙" message:@"請連接網路！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:okButton];
        [self presentViewController:alertController animated:YES completion:nil];
    }
else {
    [self getData];
//    PFQuery *query = [PFQuery queryWithClassName:@"CoffeeShop"];
//    [query orderByDescending:@"createdAt"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable
//                                              objects, NSError * _Nullable error) {
//        coffeeShopArray = [objects mutableCopy];
//        self.refreshControl = [[UIRefreshControl alloc] init];
//        [self.refreshControl addTarget:self action:@selector(refresh)
//                      forControlEvents:UIControlEventValueChanged];
//        [self.tableView addSubview:self.refreshControl];
//
//        [self.tableView reloadData];
//    }];
 }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return coffeeShopArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CoffeeTableViewCell *cell = [tableView
                           dequeueReusableCellWithIdentifier:@"coffeeCell"
                           forIndexPath:indexPath];
    if (coffeeShopArray != nil) {
        NSDictionary *dic = coffeeShopArray[indexPath.row];
        cell.coffeeName.text = dic[@"name"];
        cell.coffeeAddress.text = dic[@"address"];
        cell.coffeeImage.image = nil;
        NSData *photo = dic[@"photo"];
        cell.coffeeImage.image = [[UIImage alloc] initWithData:photo];
//        NSNull *wrong = [NSNull null];
//        if (photo != wrong) {
//            [photo getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError *
//                                                  _Nullable error) {
//                if(error == nil) {
//                    UIImage *image = [[UIImage alloc] initWithData:data];
//                    cell.coffeeImage.image = image;
//                }
//            }];
//        }
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:
(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
               [coffeeShopArray[indexPath.row] deleteInBackground] ;
        [coffeeShopArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
}

-(void)addCoffeeNoti:(NSNotification*)noti {
    //    NSDictionary *movieDic = noti.userInfo;
    NSMutableDictionary * coffeeDic = [noti.userInfo mutableCopy];
    PFObject *coffee = [PFObject objectWithClassName:@"CoffeeShop"];
    coffee[@"name"] = coffeeDic[@"name"];
    coffee[@"address"] = coffeeDic[@"address"];
    coffee[@"phone"] = coffeeDic[@"phone"];
    coffee[@"webUrl"] = coffeeDic[@"webUrl"];
    coffee[@"detail"] = coffeeDic[@"detail"];
    coffee[@"photo"] = coffeeDic[@"photo"];
    [coffee saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [coffeeShopArray insertObject:coffee atIndex:0];
            NSLog(@"存檔成功！");
            [self.tableView reloadData];
        }
    }];
}

-(void)refresh{
//        PFQuery *query = [PFQuery queryWithClassName:@"CoffeeShop"];
//        [query orderByDescending:@"createdAt"];
//        coffeeShopArray = [[query findObjects] mutableCopy];
        [self getData];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:indexPath];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showDetail"] ) {
        DetailViewController *controller = [segue destinationViewController];
        NSIndexPath *indexPath = sender;
        NSDictionary *dic = coffeeShopArray[indexPath.row];
        controller.coffeeDic = dic;
    }
    
    
}
-(void)getData
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoffeeShop" inManagedObjectContext:delegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *array = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *tmpArray  = [@[] mutableCopy];
    for(CoffeeShop *coffeeShop in array){
        NSDictionary *coffee = @{@"name":coffeeShop.name,@"address":coffeeShop.address,@"phone":coffeeShop.phone,@"webUrl":coffeeShop.weburl,@"detail":coffeeShop.detail,@"photo":coffeeShop.photo};
        [tmpArray insertObject:coffee atIndex:0];
//        NSLog(@"songci %@", songCi.name);
    };
    coffeeShopArray = tmpArray;
}

@end

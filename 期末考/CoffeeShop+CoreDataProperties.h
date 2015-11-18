//
//  CoffeeShop+CoreDataProperties.h
//  期末考
//
//  Created by 鄭涵嚴 on 2015/11/16.
//  Copyright © 2015年 鄭涵嚴. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CoffeeShop.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoffeeShop (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSNumber *phone;
@property (nullable, nonatomic, retain) NSString *weburl;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSData *photo;

@end

NS_ASSUME_NONNULL_END

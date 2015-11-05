//
//  MyAnnotation.h
//  期末考
//
//  Created by 鄭涵嚴 on 2015/11/5.
//  Copyright © 2015年 鄭涵嚴. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
-(id)initWithCoordinate:(CLLocationCoordinate2D)argCoordinate
                  title:(NSString*)argTitle subtitle:
(NSString*)argSubtitle;
@end

//
//  XOC.h
//  lejia
//
//  Created by X on 15/10/17.
//  Copyright © 2015年 XSwiftTemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JPUSHService.h"

@interface XOC : NSObject

+ (id) classFromName:(NSString*)name;
+ (UIViewController *)activityViewController;
+(void) initJPush;
//+ (NSArray*)ShareTypeList;
@end

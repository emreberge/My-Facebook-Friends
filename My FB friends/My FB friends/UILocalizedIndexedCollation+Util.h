//
//  UILocalizedIndexedCollation+Util.h
//  My FB friends
//
//  Created by Emre Ergenekon on 2/19/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILocalizedIndexedCollation (Util)

+ (NSArray *) collateObjects:(NSArray *) objects usingCollationStringSelector:(SEL) selector;

@end

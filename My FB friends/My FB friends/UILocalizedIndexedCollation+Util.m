//
//  UILocalizedIndexedCollation+Util.m
//  My FB friends
//
//  Created by Emre Ergenekon on 2/19/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import "UILocalizedIndexedCollation+Util.h"

@implementation UILocalizedIndexedCollation (Util)

+ (NSArray *) collateObjects:(NSArray *) objects usingCollationStringSelector:(SEL) selector
{
    NSMutableArray *collatedObjects = [NSMutableArray array];
    UILocalizedIndexedCollation *currentCollation = [UILocalizedIndexedCollation currentCollation];
    
    for (id object in objects) {
        NSInteger sectionIndex = [currentCollation sectionForObject:object collationStringSelector:selector];        
        
        while([collatedObjects count] <= sectionIndex)
            [collatedObjects addObject:[NSMutableArray array]];
        
        [[collatedObjects objectAtIndex:sectionIndex] addObject:object];
    }
    
    for (NSInteger index = 0; index < [collatedObjects count] ; index++) {
        [collatedObjects replaceObjectAtIndex:index withObject:[currentCollation sortedArrayFromArray:[collatedObjects objectAtIndex:index] collationStringSelector:@selector(name)]];
    }
    
    return collatedObjects;
    
}

@end

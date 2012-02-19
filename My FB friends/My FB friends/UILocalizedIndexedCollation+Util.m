//
//  UILocalizedIndexedCollation+Util.m
//  My FB friends
//
//  Created by Emre Ergenekon on 2/19/12.
//  Copyright (c) 2012 Bontouch AB, Codely HB. All rights reserved.
//

#import "UILocalizedIndexedCollation+Util.h"

@interface UILocalizedIndexedCollation ()

+ (void) makeSureMutableArray:(NSMutableArray *) array hasIndex:(NSInteger) index;
+ (NSMutableArray *) divideObjects:(NSArray *) objects intoSectionsUsingCollationStringSelector:(SEL) selector andCollation:(UILocalizedIndexedCollation *) collation;
+ (void) sortDividedObjects:(NSMutableArray *) dividedObjects usingCollationStringSelector:(SEL) selector andCollation:(UILocalizedIndexedCollation *) currentCollation;

@end

@implementation UILocalizedIndexedCollation (Util)

+ (NSArray *) collateObjects:(NSArray *) objects usingCollationStringSelector:(SEL) selector
{
    UILocalizedIndexedCollation *currentCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *collatedObjects = [self divideObjects:objects intoSectionsUsingCollationStringSelector:selector andCollation:currentCollation];
    [self sortDividedObjects:collatedObjects usingCollationStringSelector:selector andCollation:currentCollation];
    return collatedObjects;
}

+ (NSMutableArray *) divideObjects:(NSArray *) objects intoSectionsUsingCollationStringSelector:(SEL) selector andCollation:(UILocalizedIndexedCollation *) collation
{
    NSMutableArray *dividedObjects = [NSMutableArray array];
    for (id object in objects){
        NSInteger sectionIndex = [collation sectionForObject:object collationStringSelector:selector];
        [self makeSureMutableArray:dividedObjects hasIndex:sectionIndex];
        [[dividedObjects objectAtIndex:sectionIndex] addObject:object];
    }
    return dividedObjects;
    
}

+ (void) makeSureMutableArray:(NSMutableArray *) array hasIndex:(NSInteger) index
{
    while([array count] <= index)
        [array addObject:[NSMutableArray array]];
    
}

+ (void) sortDividedObjects:(NSMutableArray*) dividedObjects usingCollationStringSelector:(SEL) selector andCollation:(UILocalizedIndexedCollation*) currentCollation
{
    for (NSInteger index = 0; index < [dividedObjects count] ; index++) {
        [dividedObjects replaceObjectAtIndex:index withObject:[currentCollation sortedArrayFromArray:[dividedObjects objectAtIndex:index] collationStringSelector:selector]];
    }
} 
@end

//
//  WTTextPosition.m
//  WTTextView
//
//  Created by yandere on 2018/3/27.
//  Copyright © 2018年 org.objc.yandere. All rights reserved.
//

#import "WTTextPosition.h"

@implementation WTTextPosition

+ (instancetype)textPositionWithIndex:(NSInteger)index {
    if (index == NSNotFound) {
        return nil;
    }
    WTTextPosition *textPosition = [[self alloc] init];
    textPosition.index = index;
    return textPosition;
}

@end

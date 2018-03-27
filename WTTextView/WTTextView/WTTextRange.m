//
//  WTTextRange.m
//  WTTextView
//
//  Created by yandere on 2018/3/27.
//  Copyright © 2018年 org.objc.yandere. All rights reserved.
//

#import "WTTextRange.h"
#import "WTTextPosition.h"

@implementation WTTextRange

+ (instancetype)textRangeWithRange:(NSRange)range {
    if (range.location == NSNotFound) {
        return nil;
    }
    WTTextRange *textRange = [[self alloc] init];
    textRange.range = range;
    return textRange;
}

- (UITextPosition *)start {
    return [WTTextPosition textPositionWithIndex:self.range.location];
}

- (UITextPosition *)end {
    return [WTTextPosition textPositionWithIndex:self.range.location + self.range.length];
}

@end

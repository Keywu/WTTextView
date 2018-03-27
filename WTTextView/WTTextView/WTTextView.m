//
//  WTTextView.m
//  WTTextView
//
//  Created by yandere on 2018/3/27.
//  Copyright © 2018年 org.objc.yandere. All rights reserved.
//

#import "WTTextView.h"
#import "WTTextPosition.h"
#import "WTTextRange.h"

@interface WTTextView()

@property (nonatomic, copy) NSString *text;

@end

@implementation WTTextView

#pragma mark - UITextInput protocol required methods

- (NSString *)textInRange:(UITextRange *)range {
    return @"";
}

- (void)replaceRange:(UITextRange *)range withText:(NSString *)text {
    
}

- (void)setMarkedText:(NSString *)markedText selectedRange:(NSRange)selectedRange {
    
}

- (void)unmarkText {
    
}

- (UITextRange *)textRangeFromPosition:(UITextPosition *)fromPosition toPosition:(UITextPosition *)toPosition {
    WTTextPosition *startPosition = (WTTextPosition *)fromPosition;
    WTTextPosition *endPosition = (WTTextPosition *)toPosition;
    WTTextRange *textRange = [WTTextRange textRangeWithRange:NSMakeRange(MIN(startPosition.index, endPosition.index), ABS(startPosition.index - endPosition.index))];
    return textRange;
}

- (UITextPosition *)positionFromPosition:(UITextPosition *)position offset:(NSInteger)offset {
    WTTextPosition *textPosition = (WTTextPosition *)position;
    NSInteger end = textPosition.index + offset;
    //校验position是不是在文字当中
    if (end > self.text.length || end < 0) {
        return nil;
    }
    return [WTTextPosition textPositionWithIndex:end];
}

- (UITextPosition *)positionFromPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset {
    WTTextPosition *textPosition = (WTTextPosition *)position;
    NSInteger index = textPosition.index;
    switch (direction) {
        case UITextLayoutDirectionLeft:
            index -= offset;
            break;
            
        case UITextLayoutDirectionRight:
            index += offset;
            break;
            
        default:
            break;
    }
    if (index < 0) {
        index = 0;
    } else if (index > self.text.length) {
        index = self.text.length;
    }
    return [WTTextPosition textPositionWithIndex:index];
}

- (NSComparisonResult)comparePosition:(UITextPosition *)position toPosition:(UITextPosition *)other {
    WTTextPosition *textPosition = (WTTextPosition *)position;
    WTTextPosition *otherPosition = (WTTextPosition *)other;
    if (textPosition.index < otherPosition.index) {
        return NSOrderedAscending;
    } else if (textPosition.index > otherPosition.index) {
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}

- (NSInteger)offsetFromPosition:(UITextPosition *)from toPosition:(UITextPosition *)toPosition {
    WTTextPosition *startPosition = (WTTextPosition *)from;
    WTTextPosition *endPosition = (WTTextPosition *)toPosition;
    return endPosition.index - startPosition.index;
}

- (UITextPosition *)positionWithinRange:(UITextRange *)range farthestInDirection:(UITextLayoutDirection)direction {
    WTTextRange *textRange = (WTTextRange *)range;
    NSInteger index = 0;
    switch (direction) {
        case UITextLayoutDirectionLeft:
        case UITextLayoutDirectionUp:
            index = textRange.range.location;
            break;
            
        case UITextLayoutDirectionRight:
        case UITextLayoutDirectionDown:
            index = textRange.range.location + textRange.range.length;
            break;
            
        default:
            break;
    }
    return [WTTextPosition textPositionWithIndex:index];
}

- (UITextRange *)characterRangeByExtendingPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction {
    WTTextPosition *textPosition = (WTTextPosition *)position;
    NSRange range;
    switch (direction) {
        case UITextLayoutDirectionUp:
        case UITextLayoutDirectionLeft:
            range = NSMakeRange(textPosition.index - 1, 1);
            break;
            
        case UITextLayoutDirectionDown:
        case UITextLayoutDirectionRight:
            range = NSMakeRange(textPosition.index, 1);
            break;
            
        default:
            break;
    }
    return [WTTextRange textRangeWithRange:range];
}

@end

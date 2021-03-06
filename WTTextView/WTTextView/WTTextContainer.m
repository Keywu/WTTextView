//
//  WTTextContainer.m
//  WTTextView
//
//  Created by macmini on 2018/3/29.
//  Copyright © 2018年 org.objc.yandere. All rights reserved.
//

#import "WTTextContainer.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/CALayer.h>

@interface WTTextContainer() {
    CTFramesetterRef _framesetter;
    CTFrameRef _ctFrame;
}

@end

@implementation WTTextContainer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _text = @"";
        //转换成core graphcis的坐标系统
        self.layer.geometryFlipped = YES;
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_ctFrame != NULL) {
        [self updateCTFrame];
    }
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    if (_ctFrame != NULL) {
        [self updateCTFrame];
    }
}

- (void)textChanged {
    [self setNeedsDisplay];
    [self clearPreviousLayoutInformation];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    
    if (_framesetter != NULL) {
        CFRelease(_framesetter);
    }
    _framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    [self updateCTFrame];
}

- (void)updateCTFrame {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    if (_ctFrame != NULL) {
        CFRelease(_ctFrame);
    }
    _ctFrame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), [path CGPath], NULL);
}

- (void)clearPreviousLayoutInformation {
    if (_framesetter != NULL) {
        CFRelease(_framesetter);
        _framesetter = nil;
    }
    if (_ctFrame != NULL) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

- (void)drawSelectionRange:(NSRange)selectionRange {
    if (selectionRange.length == 0 || selectionRange.location == NSNotFound) return;
    [[UIColor greenColor] setFill];
    CFArrayRef lines = CTFrameGetLines(_ctFrame);
    CFIndex linesCount = CFArrayGetCount(lines);
    for (CFIndex linesIndex = 0; linesIndex < linesCount; linesIndex++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, linesIndex);
        CFRange lineRange = CTLineGetStringRange(line);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
    }
}

@end

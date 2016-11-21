//
//  FBTextView.m
//  freebie_cli
//
//  Created by Boris Kuznetsov on 15/11/2016.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import "FBTextView.h"

@implementation FBTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init {
    self = [super init];
    
    if (self){
        
    }
    
    return  self;
}

- (void) FBSetText:(NSString *)text{
    [super setText:text];
    
    CGFloat fixedWidth = self.frame.size.width;
    CGSize newSize = [self sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    NSLog(@"%f", newSize.height);
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    self.frame = newFrame;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
}

@end

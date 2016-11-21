//
//  FBTextView.h
//  freebie_cli
//
//  Created by Boris Kuznetsov on 15/11/2016.
//  Copyright © 2016 Boris Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBTextView : UITextView <UITextViewDelegate>

- (void) FBSetText: (NSString*) text;
- (void) textViewDidChange: (UITextView*) textView;

@end

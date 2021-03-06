//
//  DoneCancelNumberPadToolbar.h
//
//  Created by Timothy Broder on 8/17/12.
//  Based on http://stackoverflow.com/a/11382326/647343 by Luda
//  Updates from akozlik http://www.reddit.com/r/iOSProgramming/comments/ydrzv/adding_done_and_cancel_buttons_to_an_ios_number/c5v4rpt
//
//

#import <UIKit/UIKit.h>

@class DoneCancelNumberPadToolbar;

@protocol DoneCancelNumberPadToolbarDelegate <NSObject>

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickDone:(UITextField *)textField;
-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickCancel:(UITextField *)textField;

-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickViewDone:(UITextView *)textView;
-(void)doneCancelNumberPadToolbarDelegate:(DoneCancelNumberPadToolbar *)controller didClickViewCancel:(UITextView *)textView;


@end

@interface DoneCancelNumberPadToolbar : UIToolbar
{
    UITextField *textField;
    UITextView  *textView;
}

//@property (nonatomic, weak) id <DoneCancelNumberPadToolbarDelegate> delegate;
@property(nonatomic, weak) id<DoneCancelNumberPadToolbarDelegate, UIToolbarDelegate> delegate;

- (id) initWithTextField:(UITextField *)aTextField;
- (id) initWithTextField:(UITextField *)aTextField withKeyboardType:(int)keyboardType;

- (id) initWithTextView:(UITextView *)aTextView;
- (id) initWithTextView:(UITextView *)aTextView withKeyboardType:(int)keyboardType;

@end

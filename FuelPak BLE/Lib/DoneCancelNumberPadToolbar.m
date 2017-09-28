//
//  DoneCancelNumberPadToolbar.m
//
//  Created by Timothy Broder on 8/17/12.
//
//

#import "DoneCancelNumberPadToolbar.h"


@implementation DoneCancelNumberPadToolbar

@synthesize delegate;

- (id) initWithTextField:(UITextField *)aTextField
{
    return [self initWithTextField:aTextField withKeyboardType:UIKeyboardTypeDecimalPad];
}

- (id) initWithTextField:(UITextField *)aTextField withKeyboardType:(int)keyboardType
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 50)];
    if (self)
    {
        textField = aTextField;
        [textField setKeyboardType:keyboardType];
        self.barStyle = UIBarStyleBlack;
        self.items = [NSArray arrayWithObjects:
                      [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                   target:nil action:nil],
                      
#ifdef FORCE_RELEASE
#else
                      //                      [[UIBarButtonItem alloc]initWithTitle:@"Touring"
                      //                                                      style:UIBarButtonItemStyleBordered
                      //                                                     target:self
                      //                                                     action:@selector(showTouring)],
                      //
                      //
                      
                      //                      [[UIBarButtonItem alloc]initWithTitle:@"Softail"
                      //                                                      style:UIBarButtonItemStyleBordered
                      //                                                     target:self
                      //                                                     action:@selector(showSoftail)],
                      
                      //
                      //                      [[UIBarButtonItem alloc]initWithTitle:@"Dyna"
                      //                                                      style:UIBarButtonItemStyleBordered
                      //                                                     target:self
                      //                                                     action:@selector(showDyna)],
                      //
                      //                      [[UIBarButtonItem alloc]initWithTitle:@"Street"
                      //                                                      style:UIBarButtonItemStyleBordered
                      //                                                     target:self
                      //                                                     action:@selector(showStreet)],
                      //
                      //                      [[UIBarButtonItem alloc]initWithTitle:@"Sport"
                      //                                                      style:UIBarButtonItemStyleBordered
                      //                                                     target:self
                      //                                                     action:@selector(showSportster)],
                      //
                      //                      [[UIBarButtonItem alloc]initWithTitle:@"CVO"
                      //                                                      style:UIBarButtonItemStyleBordered
                      //                                                     target:self
                      //                                                     action:@selector(showCVO)],
                      //
                      //                      [[UIBarButtonItem alloc]initWithTitle:@"Trke"
                      //                                                      style:UIBarButtonItemStyleBordered
                      //                                                     target:self
                      //                                                     action:@selector(showTrike)],
#endif
                      
                      [[UIBarButtonItem alloc]initWithTitle:@"✓"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(doneWithNumberPad)],
                      nil];
        //[self sizeToFit];
        
    }
    return self;
}


-(void)cancelNumberPad
{
    [textField resignFirstResponder];
    textField.text = @"";
    [self.delegate doneCancelNumberPadToolbarDelegate:self didClickCancel:textField];
}


//-(void)show1HD
//{
//    //[textField resignFirstResponder];
//    textField.text = @"1HD1kRM11eb713814";
//    //[self.delegate doneCancelNumberPadToolbarDelegate:self didClickCancel:textField];
//}

//-(void)show5HD
//{
//    //[textField resignFirstResponder];
//    textField.text = @"5HD";
//    //[self.delegate doneCancelNumberPadToolbarDelegate:self didClickCancel:textField];
//}
//
//-(void)showMEG
//{
//    //[textField resignFirstResponder];
//    textField.text = @"MEG";
//    //[self.delegate doneCancelNumberPadToolbarDelegate:self didClickCancel:textField];
//}
//
//-(void)show932
//{
//    //[textField resignFirstResponder];
//    textField.text = @"932";
//    //[self.delegate doneCancelNumberPadToolbarDelegate:self didClickCancel:textField];
//}



-(void) showTouring
{
    textField.text = @"1HD1kRM11eb713814";
}

-(void) showSoftail
{
    textField.text = @"5HD1BXVC9EB031485";
}

-(void) showDyna
{
    textField.text = @"MEG1GX4N1FN305928";
}
-(void) showCVO
{
    textField.text = @"5HD1TD9e5EB960631";
}
-(void) showSportster
{
    textField.text = @"9321LC3jxeD422532";
}
-(void) showStreet
{
    textField.text = @"MEG4NBBN7fn503809";
}
-(void) showTrike
{
    textField.text = @"1HD1mcm19Fb853912";
}








-(void)doneWithNumberPad
{
    [textField resignFirstResponder];
    [self.delegate doneCancelNumberPadToolbarDelegate:self didClickDone:textField];
}


- (id) initWithTextView:(UITextView *)aTextView
{
    return [self initWithTextView:aTextView withKeyboardType:UIKeyboardTypeDecimalPad];
}


- (id) initWithTextView:(UITextView *)aTextView withKeyboardType:(int)keyboardType
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 50)];
    if (self) {
        textView = aTextView;
        [textView setKeyboardType:keyboardType];
        self.barStyle = UIBarStyleBlack;
        self.items = [NSArray arrayWithObjects:
                      [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                   target:nil action:nil],
                      
                      //[[UIBarButtonItem alloc]initWithTitle:@"Cancel"
                      //                                style:UIBarButtonItemStyleBordered
                      //                               target:self
                      //                               action:@selector(cancelNumberViewPad)],
                      
                      [[UIBarButtonItem alloc]initWithTitle:@"✓"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(doneWithNumberViewPad)],
                      nil];
        //[self sizeToFit];
        
    }
    return self;
}

-(void)cancelNumberViewPad
{
    [textView resignFirstResponder];
    textView.text = @"";
    [self.delegate doneCancelNumberPadToolbarDelegate:self didClickViewCancel:textView];
}

-(void)doneWithNumberViewPad
{
    [textView resignFirstResponder];
    
    [self.delegate doneCancelNumberPadToolbarDelegate:self didClickViewDone:textView];
}


@end

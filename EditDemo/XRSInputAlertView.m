//
//  XRSInputAlertView.m
//  club
//
//  Created by sunshuaikun on 17/2/15.
//  Copyright © 2017年. All rights reserved.
//

#import "XRSInputAlertView.h"

@interface XRSInputAlertView ()<UITextFieldDelegate>{
    UILabel      *_messageLabel;
    UITextField  *_textField;
}
@end

@implementation XRSInputAlertView

- (id _Nonnull)initWithTitle:( NSString * _Nullable)title delegate:(id<XRSInputAlertViewDelegate> _Nullable)delegate message:( NSString * _Nullable)message confirmButton:( NSString * _Nonnull)confirmTitle
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.delegate = delegate;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer *tapWindowGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWindow)];
        [self addGestureRecognizer:tapWindowGesture];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(50, 140, [UIScreen mainScreen].bounds.size.width-100, 198)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.cornerRadius = 8.0f;
        [self addSubview:backgroundView];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(backgroundView.frame.size.width-30, 5, 25, 25)];
        //[closeButton setImage:[UIImage imageNamed:@"home_cancel"] forState:UIControlStateNormal];
        [closeButton setTitle:@"X" forState:UIControlStateNormal];
        [closeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [closeButton addTarget:self action:@selector(hideAlertView) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:closeButton];
        
        UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(closeButton.frame)+3, backgroundView.frame.size.width, 25)];
        [labelTip setFont:[UIFont systemFontOfSize:21]];
        [labelTip setTextColor:[UIColor darkTextColor]];
        [labelTip setTextAlignment:NSTextAlignmentCenter];
        [labelTip setText:title];
        [backgroundView addSubview:labelTip];
        
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(labelTip.frame)+20,backgroundView.frame.size.width-60, 40)];
        _textField.delegate = self;
        _textField.layer.borderWidth = 1.0f;
        _textField.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0].CGColor;
         [backgroundView addSubview:_textField];
         [_textField becomeFirstResponder];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textField.frame)+5, backgroundView.frame.size.width, 25)];
        [_messageLabel setTextColor:[UIColor colorWithRed:216/255.0 green:81/255.0 blue:83/255.0 alpha:1.0]];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        [backgroundView addSubview:_messageLabel];
        
        UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(backgroundView.frame)-45, CGRectGetWidth(backgroundView.frame), 45)];
        [confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor colorWithRed:38/255.0f green:119/255.0f blue:218/255.0f alpha:1.0] forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:confirmButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, confirmButton.frame.size.width, 1.0)];
        [lineView setBackgroundColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]];
        [confirmButton addSubview:lineView];
    }
    return  self;
}

#pragma mark events

- (void)hideAlertView
{
    [self removeFromSuperview];
}

- (void)hideWindow
{
    [self removeFromSuperview];
}

- (void)confirm
{
    //规则校验
    
    if ([self.delegate respondsToSelector:@selector(xrsInputAlertView:clickedButtonWithContent:)]) {
        [self.delegate xrsInputAlertView:self clickedButtonWithContent:_textField.text];
    }
}

- (void)updateMessage:(NSString *)message
{
    [_messageLabel setText:message];
}

#pragma mark textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

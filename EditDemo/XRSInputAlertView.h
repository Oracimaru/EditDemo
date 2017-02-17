//
//  XRSInputAlertView.h
//  club
//
//  Created by sunshuaikun on 17/2/15.
//  Copyright © 2017年. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XRSInputAlertView;

@protocol XRSInputAlertViewDelegate <NSObject>
@optional
- (void)xrsInputAlertView:( XRSInputAlertView * _Nullable)inputAlertView clickedButtonWithContent:(NSString * _Nonnull)content;
@end

@interface XRSInputAlertView : UIView

@property(nonatomic,assign)_Nullable id<XRSInputAlertViewDelegate> delegate;

- (id _Nonnull)initWithTitle:( NSString * _Nullable)title delegate:(id<XRSInputAlertViewDelegate> _Nullable)delegate message:( NSString * _Nullable)message confirmButton:( NSString * _Nonnull)confirmTitle;
- (void)updateMessage:(NSString * _Nonnull)message;
@end

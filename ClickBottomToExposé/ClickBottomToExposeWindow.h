//
//  ClickBottomToExposeWindow.h
//  ClickBottomToExposé
//
//  Created by HatanoKenta on 2018/12/11.
//

#import <Cocoa/Cocoa.h>

@interface ClickBottomToExposeWindow : NSWindow <NSWindowDelegate>

- (void)appNameShowing:(NSTimer *)timer;

+ (void)showMissionControl;
+ (void)showApplicationWindows;
+ (void)showDesktop;

@end

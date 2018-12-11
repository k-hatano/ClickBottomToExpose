//
//  ClickBottomToExposeWindow.m
//  ClickBottomToExposé
//
//  Created by HatanoKenta on 2018/12/11.
//

#import "ClickBottomToExposeWindow.h"

@implementation ClickBottomToExposeWindow

- (void)awakeFromNib {
    self.level = NSPopUpMenuWindowLevel;
    
    [self setOpaque:NO];
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.5]];
    
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:[self.contentView frame] options:NSTrackingMouseEnteredAndExited | NSTrackingInVisibleRect | NSTrackingActiveAlways owner:self userInfo:nil];
    [self.contentView addTrackingArea:area];
}

- (void)mouseDown:(NSEvent *)theEvent {
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
}

- (void)mouseUp:(NSEvent *)theEvent {
    [ClickBottomToExposeWindow showApplicationWindows];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.5]];
}

- (void)mouseExited:(NSEvent *)theEvent {
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
}

+ (void)showMissionControl {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/open";
    task.arguments = @[@"-a", @"mission control"];
    [task launch];
}

+ (void)showApplicationWindows {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/open";
    task.arguments = @[@"-a", @"mission control", @"--args", @"2"];
    [task launch];
}

+ (void)showDesktop {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/open";
    task.arguments = @[@"-a", @"mission control", @"--args", @"1"];
    [task launch];
}

@end

//
//  ClickBottomToExposeWindow.m
//  ClickBottomToExposé
//
//  Created by HatanoKenta on 2018/12/11.
//

#import "ClickBottomToExposeWindow.h"

@interface ClickBottomToExposeWindow ()

@property (strong) NSTimer *timer;
@property (assign) BOOL isMousePressed;
@property (assign) float totalScroll;

@end

@implementation ClickBottomToExposeWindow

- (void)awakeFromNib {
    self.level = NSPopUpMenuWindowLevel;
    
    [self setOpaque:NO];
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.5]];
    
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:[self.contentView frame] options:NSTrackingMouseEnteredAndExited | NSTrackingInVisibleRect | NSTrackingActiveAlways owner:self userInfo:nil];
    [self.contentView addTrackingArea:area];
    
    self.isMousePressed = NO;
}

- (void)mouseDown:(NSEvent *)theEvent {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (self.isMousePressed) {
            NSArray<NSRunningApplication *> *applications = [[NSWorkspace sharedWorkspace] runningApplications];
            for (NSRunningApplication *app in applications) {
                if ([app ownsMenuBar]) {
                    [app activateWithOptions:NSApplicationActivateIgnoringOtherApps];
                    break;
                }
            }
            
            [ClickBottomToExposeWindow showApplicationWindows];
        }
    }];
    self.isMousePressed = YES;
}

- (void)mouseUp:(NSEvent *)theEvent {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
    }
    self.isMousePressed = NO;
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.5]];
}

- (void)mouseExited:(NSEvent *)theEvent {
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
}

- (void)scrollWheel:(NSEvent *)theEvent
{
    self.totalScroll += theEvent.deltaY;
    if (self.totalScroll < -4) {
        [ClickBottomToExposeWindow showMissionControl];
        self.totalScroll = 0;
    }
    if (self.totalScroll > 4) {
        [ClickBottomToExposeWindow showApplicationWindows];
        self.totalScroll = 0;
    }
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

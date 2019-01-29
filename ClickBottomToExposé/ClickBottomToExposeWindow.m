//
//  ClickBottomToExposeWindow.m
//  ClickBottomToExposé
//
//  Created by HatanoKenta on 2018/12/11.
//

#import "ClickBottomToExposeWindow.h"

@interface ClickBottomToExposeWindow ()

@property (weak) IBOutlet NSWindow *appNameWindow;
@property (weak) IBOutlet NSTextField *appNameField;

@property (strong) NSTimer *mousePressTimer;
@property (strong) NSTimer *appNameShowingTimer;
@property (assign) BOOL isMousePressed;
@property (assign) float totalScroll;
@property (assign) NSInteger appNameShowingCount;

@end

@implementation ClickBottomToExposeWindow

- (void)awakeFromNib {
    [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.5]];
    [self.appNameWindow setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.5]];
    
    [self setOpaque:NO];
    [self.appNameWindow setOpaque:NO];
    [self.appNameWindow setAlphaValue:0.0f];
    
    self.level = NSPopUpMenuWindowLevel;
    self.appNameWindow.level = NSPopUpMenuWindowLevel;
    
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:[self.contentView frame] options:NSTrackingMouseEnteredAndExited | NSTrackingInVisibleRect | NSTrackingActiveAlways owner:self userInfo:nil];
    [self.contentView addTrackingArea:area];
    
    self.isMousePressed = NO;
}

- (void)appNameShowing:(NSTimer *)timer {
    if (self.appNameShowingCount >= 133) {
        [self.appNameWindow setOpaque:NO];
        [self.appNameWindow setAlphaValue:0.0f];
    } else if (self.appNameShowingCount >= 100) {
        [self.appNameWindow setAlphaValue:(133.0f - self.appNameShowingCount) / 33.0f];
        self.appNameShowingCount++;
        self.appNameShowingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(appNameShowing:) userInfo:nil repeats:NO];
    } else {
        self.appNameShowingCount++;
        self.appNameShowingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(appNameShowing:) userInfo:nil repeats:NO];
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    self.mousePressTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (self.isMousePressed) {
            [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
            NSArray<NSRunningApplication *> *applications = [[NSWorkspace sharedWorkspace] runningApplications];
            for (NSRunningApplication *app in applications) {
                if (app.ownsMenuBar) {
                    NSRect oldFieldRect = self.appNameField.frame;
                    [self.appNameField setStringValue:app.localizedName];
                    [self.appNameField sizeToFit];
                    NSRect newFieldRect = self.appNameField.frame;
                    
                    NSRect windowRect = self.appNameWindow.frame;
                    windowRect.origin.x -= (newFieldRect.size.width - oldFieldRect.size.width) / 2.0f;
                    windowRect.size.width += (newFieldRect.size.width - oldFieldRect.size.width);
                    [self.appNameWindow setFrame:windowRect display:NO];
                    [self.appNameField setFrame:newFieldRect];
                    
                    [self.appNameWindow setAlphaValue:1.0f];
                    [self.appNameWindow setOpaque:YES];
                    [self.appNameWindow setViewsNeedDisplay:YES];
                    
                    [app activateWithOptions:NSApplicationActivateIgnoringOtherApps];
                    for (NSInteger loopingCount = 0; loopingCount < 10; loopingCount++) {
                        if (app.isActive) {
                            break;
                        }
                        [NSThread sleepForTimeInterval:0.01];
                    }
                    break;
                }
            }
            
            [ClickBottomToExposeWindow showApplicationWindows];
            
            self.appNameShowingCount = 0;
            self.appNameShowingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(appNameShowing:) userInfo:nil repeats:NO];
        }
    }];
    self.isMousePressed = YES;
}

- (void)mouseUp:(NSEvent *)theEvent {
    if (self.mousePressTimer) {
        [self.mousePressTimer invalidate];
        self.mousePressTimer = nil;
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
        [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
    }
    if (self.totalScroll > 4) {
        [self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.0]];
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

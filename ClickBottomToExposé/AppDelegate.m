//
//  AppDelegate.m
//  ClickBottomToExposé
//
//  Created by HatanoKenta on 2018/12/11.
//

#import "AppDelegate.h"
#import "ClickBottomToExposeWindow.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[NSApplication sharedApplication] setPresentationOptions: NSApplicationPresentationAutoHideMenuBar];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showMissionControl:(id)sender {
    [ClickBottomToExposeWindow showMissionControl];
}

- (IBAction)showApplicationWidows:(id)sender {
    [ClickBottomToExposeWindow showApplicationWindows];
}

- (IBAction)showDesktop:(id)sender {
    [ClickBottomToExposeWindow showDesktop];
}

- (IBAction)quitClickBottomToExpose:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

@end

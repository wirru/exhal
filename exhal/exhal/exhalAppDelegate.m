//
//  exhalAppDelegate.m
//  exhal
//
//  Created by William Wu on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "exhalAppDelegate.h"

@interface exhalAppDelegate () <DBRestClientDelegate>

- (void)updateLinkButton;
- (DBRestClient *)restClient;

@property (nonatomic, retain) NSString *requestToken;
@end

@implementation exhalAppDelegate

@synthesize window = _window;
@synthesize filepath = _filepath;
@synthesize requestToken;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSString *appKey = @"lw7k9zwiwukfz2o";
    NSString *appSecret = @"zkqsrwab4ope2di";
    NSString *root = kDBRootAppFolder; // Should be either kDBRootDropbox or kDBRootAppFolder
    DBSession *session = [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
    [DBSession setSharedSession:session];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authHelperStateChangedNotification:) name:DBAuthHelperOSXStateChangedNotification object:[DBAuthHelperOSX sharedHelper]];
    //[self updateLinkButton];
    
    NSAppleEventManager *em = [NSAppleEventManager sharedAppleEventManager];
    [em setEventHandler:self andSelector:@selector(getUrl:withReplyEvent:)
          forEventClass:kInternetEventClass andEventID:kAEGetURL];
    
    /*if ([[DBSession sharedSession] isLinked]) {
        [self uploadFile:nil];
    }*/
}

- (IBAction)uploadFile:(id)sender {
    // write something here
    NSString *fp = self.filepath.stringValue;
    
   
    
    NSLog(@"%@", fp);
}

- (IBAction)didPressLinkDropbox:(id)sender {
    if ([[DBSession sharedSession] isLinked]) {
        // The link button turns into an unlink button when you're linked
        [[DBSession sharedSession] unlinkAll];
        restClient = nil;
        //[self updateLinkButton];
    } else {
        [[DBAuthHelperOSX sharedHelper] authenticate];
    }
}
- (void)authHelperStateChangedNotification:(NSNotification *)notification {
    //[self updateLinkButton];
    NSLog(@"Attempting to link with Dropbox...");
    if ([[DBSession sharedSession] isLinked]) {
        // You can now start using the API!
        //[self didPressRandomPhoto:nil];
        NSLog(@"Successfully linked to Dropbox!");
    }
}

- (DBRestClient *)restClient {
    if (!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

@end

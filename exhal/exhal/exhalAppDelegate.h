//
//  exhalAppDelegate.h
//  exhal
//
//  Created by William Wu on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <DropboxOSX/DropboxOSX.h>

@interface exhalAppDelegate : NSObject <NSApplicationDelegate> {
	DBRestClient *restClient;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *filepath;

- (IBAction)uploadFile:(id)sender;
- (IBAction)didPressLinkDropbox:(id)sender;

@end

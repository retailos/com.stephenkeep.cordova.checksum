
#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>

@interface CDVChecksum : CDVPlugin {}

- (void)MD5:(CDVInvokedUrlCommand*)command;

@end

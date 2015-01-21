
#include <sys/types.h>
#include <sys/sysctl.h>

#import <Cordova/CDV.h>
#import "CDVChecksum.h"

#import <CommonCrypto/CommonDigest.h>

@interface CDVChecksum () {}
@end

@implementation CDVChecksum

- (void)MD5:(CDVInvokedUrlCommand*)command {
    
    NSString *path = [command.arguments objectAtIndex:0];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data) {
        
        NSString *md5 = [self MD5Data:data];
        NSDictionary* properties = @{@"md5" : md5};
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:properties];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    } else {
        
        NSDictionary* properties = @{@"error" : @"File does not exist."};
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:properties];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (NSString*)MD5Data:(NSData *)data {
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(data.bytes, data.length, md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

@end

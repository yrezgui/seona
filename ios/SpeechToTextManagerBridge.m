//
//  SpeechToTextManagerBridge.m
//  Seona
//
//  Created by Yacine Rezgui on 28/01/2016.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(SpeechToTextManager, NSObject)

RCT_EXTERN_METHOD(startService:(NSString *)username password:(NSString *)password)

RCT_EXTERN_METHOD(startRecording:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(stopRecording)

RCT_EXTERN_METHOD(play)

RCT_EXTERN_METHOD(transcript:(RCTResponseSenderBlock)callback)

@end

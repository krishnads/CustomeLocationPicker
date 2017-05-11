//
//  NSString+urlencode.h
//  Cleanline
//
//  Created by Krishana on 2/23/17.
//  Copyright © 2017 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Extended)


/**
 Used to encode the string as URLEncode

 @return encoded string
 */
- (NSString *)urlencode;

@end

//
//  ETIntuitParser.h
//  ETParseIntuitSOExample
//
//  Created by Erik Tjernlund on 2012-11-07.
//  Copyright (c) 2012 Erik Tjernlund. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETIntuitParser : NSObject<NSXMLParserDelegate>

+ (NSDictionary *)parseIntuitXML:(NSString *)xml;

@end

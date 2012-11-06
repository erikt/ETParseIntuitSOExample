//
//  ETIntuitParser.m
//  ETParseIntuitSOExample
//
//  Created by Erik Tjernlund on 2012-11-07.
//  Copyright (c) 2012 Erik Tjernlund. All rights reserved.
//

#import "ETIntuitParser.h"

@interface ETIntuitParser ()
@property NSUInteger dataColNumber;
@property (copy,nonatomic) NSString *dataKey;
@property (strong,nonatomic) NSMutableString *currentElementValue;
@property (strong,nonatomic) NSMutableDictionary *resultDict;
@end

@implementation ETIntuitParser

+ (NSDictionary *)parseIntuitXML:(NSString *)xml {
    ETIntuitParser *intuitParser = [[ETIntuitParser alloc] init];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    [xmlParser setDelegate:intuitParser];
    BOOL success = [xmlParser parse];
    
    if (success) {
        return [NSDictionary dictionaryWithDictionary:intuitParser.resultDict];
    } else {
		NSLog(@"Error parsing login information");
        return nil;
    }
}

#pragma mark - NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"Report"]) {
        if (!self.resultDict) {
            self.resultDict = [NSMutableDictionary dictionary];
        }
        return;
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!self.currentElementValue) {
		self.currentElementValue = [[NSMutableString alloc] initWithString:string];
	} else {
		[self.currentElementValue appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"DataRow"]) {
        self.dataColNumber = 0;
    }
    
    if ([elementName isEqualToString:@"ColData"]) {
        NSString *trimmedValue = [self.currentElementValue stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (self.dataColNumber == 0) {
            self.dataKey = trimmedValue;
            self.dataColNumber++;
        } else {
            [self.resultDict setObject:trimmedValue forKey:self.dataKey];
        }
        
    }
    
	self.currentElementValue = nil;
}
@end

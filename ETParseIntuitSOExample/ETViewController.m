//
//  ETViewController.m
//  ETParseIntuitSOExample
//
//  Created by Erik Tjernlund on 2012-11-07.
//  Copyright (c) 2012 Erik Tjernlund. All rights reserved.
//

#import "ETViewController.h"
#import "ETIntuitParser.h"

@interface ETViewController ()

@end

@implementation ETViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intuit_balance_sheet" ofType:@"xml"];
    
    NSString *xml;
    
    if (filePath) {
        xml = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }

    NSDictionary *resultDict = [ETIntuitParser parseIntuitXML:xml];
    NSLog(@"%@", resultDict);

}


@end

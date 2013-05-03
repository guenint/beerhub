//
//  trgDataParse.m
//  beerhub
//
//  Created by Teddy Guenin on 5/2/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import "trgDataParse.h"
#import "CSVParser.h"

@implementation trgDataParse

-(NSArray *) createArray {
    NSArray *arrayOfArrays = [CSVParser parseCSVIntoArrayOfArraysFromFile:@"breweries.csv"
                                             withSeparatedCharacterString:@","
                                                     quoteCharacterString:nil];
    return arrayOfArrays;
}

@end

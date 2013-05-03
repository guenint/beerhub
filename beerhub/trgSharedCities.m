//
//  trgSharedCities.m
//  beerhub
//
//  Created by Teddy Guenin on 5/3/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import "trgSharedCities.h"

@implementation trgSharedCities

@synthesize cities;

static trgSharedCities *sharedInstance = nil;

+ (trgSharedCities *) sharedCities {
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        cities = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

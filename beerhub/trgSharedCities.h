//
//  trgSharedCities.h
//  beerhub
//
//  Created by Teddy Guenin on 5/3/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface trgSharedCities : NSObject

@property (nonatomic, strong) NSMutableArray *cities;

+(trgSharedCities *)sharedCities;

@end

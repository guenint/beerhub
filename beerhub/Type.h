//
//  Type.h
//  beerhub
//
//  Created by Teddy Guenin on 5/2/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Beer;

@interface Type : NSObject

@property (nonatomic, retain) NSString * name;

@property (nonatomic, retain) Beer * beer;
@end

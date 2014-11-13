//
//  SMGMapAnnotation.m
//  simplesubway
//
//  Created by Marcus Skye Lewis on 7/12/14.
//  Copyright (c) 2014 Marcus Lewis. All rights reserved.
//

#import "SMGMapAnnotation.h"

@implementation SMGMapAnnotation

- (id)initWithCoordinates:(CLLocationCoordinate2D)location
                placeName:(NSString *)placeName
              description:(NSString *)description;
{
    self = [super init];
    if (self)
    {
        self.coordinate = location;
        self.title = placeName;
        self.subtitle = description;
    }
    
    return self;
}

@end

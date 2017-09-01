//
//  SMGMapAnnotation.h
//  simplesubway
//
//  Created by Marcus Skye Lewis on 7/12/14.
//  Copyright (c) 2014 Bolt Action. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/MapKit.h>

@interface SMGMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D    coordinate;
@property (nonatomic, copy) NSString*           title;
@property (nonatomic, copy) NSString*           subtitle;

- (id)initWithCoordinates: (CLLocationCoordinate2D)  location
                placeName: (NSString *)              placeName
              description: (NSString *)              description;


@end

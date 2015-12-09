//
//  QuadTreePoint.m
//  QuadTree
//
//  Created by Rob on 8/1/15.
//  Copyright (c) 2015 Rob. All rights reserved.
//

#import "QuadTreePoint.h"

@implementation QuadTreePoint

-(instancetype)init {
    if(self = [super init]) {
        _containsNumberOfPoints = 1;
    }
    return self;
}

-(void)setPoint:(MKMapPoint)point {
    _point = point;
    self.coordinate = MKCoordinateForMapPoint(self.point);
}
@end

//
//  QuadTreePoint.h
//  QuadTree
//
//  Created by Rob on 8/1/15.
//  Copyright (c) 2015 Rob. All rights reserved.
//


#import "QuadTree.h"

@interface QuadTreePoint : MKPointAnnotation
@property (nonatomic) MKMapPoint point;
@property (nonatomic) NSUInteger containsNumberOfPoints;
@end

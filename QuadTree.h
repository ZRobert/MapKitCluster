//
//  QuadTree.h
//  QuadTree
//
//  Created by Rob on 8/1/15.
//  Copyright (c) 2015 Rob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface QuadTree : NSObject

@property (nonatomic) MKMapRect frame;

-(NSMutableArray *)pointsWithFrame:(MKMapRect)frame withResolution:(double)resolution;
-(NSMutableArray *)quadTreeFramesInFrame:(MKMapRect)frame;
-(instancetype)initWithFrame:(MKMapRect)frame;
-(void)insertPoint:(MKMapPoint)aPoint;
@end

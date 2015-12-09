//
//  QuadTreeNode.h
//  QuadTree
//
//  Created by Rob on 8/1/15.
//  Copyright (c) 2015 Rob. All rights reserved.
//

#import "QuadTree.h"
#import "QuadTreePoint.h"

@interface QuadTreeNode : NSObject

@property (nonatomic) MKMapRect frame;
@property (nonatomic) NSUInteger pointCount;
@property (nonatomic) CGFloat area;
@property (nonatomic, strong) QuadTreePoint *myPoint;
@property (nonatomic, strong) QuadTreeNode *NWNode;
@property (nonatomic, strong) QuadTreeNode *SWNode;
@property (nonatomic, strong) QuadTreeNode *SENode;
@property (nonatomic, strong) QuadTreeNode *NENode;
@property (nonatomic, strong) QuadTreeNode *parentNode;

-(instancetype) initWithFrame:(MKMapRect)frame withParent:(QuadTreeNode*)parent;
-(void) insertPoint:(MKMapPoint)aPoint;
-(void) getAveragePoint:(MKMapPoint)averagePoint;
-(NSMutableArray*) getPoints:(NSMutableArray*)points withFrame:(MKMapRect)frame andResolution:(double)resolution;
-(NSMutableArray*) getFrames:(NSMutableArray*)frames inFrame:(MKMapRect)frame;
-(BOOL) isInFrame:(MKMapRect)aFrame;
-(void)findPointsForAverage:(NSMutableArray*)array;

@end

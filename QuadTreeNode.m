//
//  QuadTreeNode.m
//  QuadTree
//
//  Created by Rob on 8/1/15.
//  Copyright (c) 2015 Rob. All rights reserved.
//

#import "QuadTreeNode.h"
#import "QuadTreePoint.h"

@implementation QuadTreeNode


-(instancetype) initWithFrame:(MKMapRect)frame withParent:(QuadTreeNode*)parent {
    if(self = [super init]) {
        _parentNode = parent;
        _frame = frame;
        _myPoint = [QuadTreePoint new];
        self.myPoint.point = MKMapPointMake(self.frame.origin.x - 1, self.frame.origin.y - 1);    //set it outside of the frame
        _pointCount = 0;
        _area = MKMapRectGetHeight(self.frame) * MKMapRectGetWidth(self.frame);
    }
    
    return self;
}

-(void) insertPoint:(MKMapPoint)aPoint {
    if(MKMapRectContainsPoint(self.frame, aPoint)) {
        if(self.myPoint.point.x == self.frame.origin.x - 1) {
            self.myPoint.point = aPoint;
            [self constructChildren];
        } else {
            if(MKMapRectContainsPoint(_NWNode.frame , aPoint)) {
                [_NWNode insertPoint:aPoint];
            } else if(MKMapRectContainsPoint(_SWNode.frame, aPoint)) {
                [_SWNode insertPoint:aPoint];
            } else if(MKMapRectContainsPoint(_SENode.frame, aPoint)) {
                [_SENode insertPoint:aPoint];
            } else if(MKMapRectContainsPoint(_NENode.frame, aPoint)) {
                [_NENode insertPoint:aPoint];
            }
            
        }
        self.pointCount++;
    } else {
        NSLog(@"Error: trying to insert point that is outside of frame!");
    }
}

-(void) getAveragePoint:(MKMapPoint)averagePoint {
    
}

-(NSMutableArray*) getPoints:(NSMutableArray*)points withFrame:(MKMapRect)frame andResolution:(double)resolution {
    if(self.myPoint.point.x == self.frame.origin.x - 1) {
        return points;
    } else {
        
        if(resolution > MIN(self.frame.size.height, self.frame.size.width)) {
            NSLog(@"Resolution %f, Min(width,height) %f", resolution, MIN(self.frame.size.width, self.frame.size.height));
            QuadTreePoint *aggregatePoint = [QuadTreePoint new];
            aggregatePoint.point = self.frame.origin;
            aggregatePoint.containsNumberOfPoints = self.pointCount;

                NSMutableArray *pointsForAverage = [NSMutableArray new];
                QuadTreeNode *temp1 = _NWNode;
                QuadTreeNode *temp2 = _SWNode;
                QuadTreeNode *temp3 = _SENode;
                QuadTreeNode *temp4 = _NENode;
                while(pointsForAverage.count < 3 && pointsForAverage.count < aggregatePoint.containsNumberOfPoints) {
                    [temp1 findPointsForAverage: pointsForAverage];
                    [temp2 findPointsForAverage: pointsForAverage];
                    [temp3 findPointsForAverage: pointsForAverage];
                    [temp4 findPointsForAverage: pointsForAverage];
                }
                double cumulativeX = 0;
                double cumulativeY = 0;
                for(QuadTreePoint *p in pointsForAverage) {
                    cumulativeX += p.point.x;
                    cumulativeY += p.point.y;
                }
                double avgX = cumulativeX / pointsForAverage.count;
                double avgY = cumulativeY / pointsForAverage.count;
                aggregatePoint.point = MKMapPointMake(avgX, avgY);
            
            [points addObject:aggregatePoint];
            return points;
        } else {
            [points addObject:self.myPoint];
            if([_NWNode isInFrame:frame]) {
                [_NWNode getPoints:points withFrame:frame andResolution:resolution];
            }
            if([_SWNode isInFrame:frame]) {
                [_SWNode getPoints:points withFrame:frame andResolution:resolution];
            }
            if([_SENode isInFrame:frame]) {
                [_SENode getPoints:points withFrame:frame andResolution:resolution];
            }
            if([_NENode isInFrame:frame]) {
                [_NENode getPoints:points withFrame:frame andResolution:resolution];
            }
            return points;
        }
    }
}

-(NSMutableArray*) getFrames:(NSMutableArray*)frames inFrame:(MKMapRect)frame {
    if([self isInFrame:frame]) {
       
        [frames addObject: self];
        [_NWNode getFrames:frames inFrame:frame];
        [_SWNode getFrames:frames inFrame:frame];
        [_SENode getFrames:frames inFrame:frame];
        [_NENode getFrames:frames inFrame:frame];
    }
    return frames;
}

-(BOOL) isInFrame:(MKMapRect)aFrame {
    return MKMapRectIntersectsRect(aFrame, self.frame) || MKMapRectContainsRect(aFrame, self.frame);
}

-(void) constructChildren {
    CGFloat halfWidth = self.frame.size.width * 0.5;
    CGFloat halfHeight = self.frame.size.height * 0.5;
    
    _NWNode = [[QuadTreeNode alloc] initWithFrame: MKMapRectMake(MKMapRectGetMinX(self.frame),
                                                              MKMapRectGetMinY(self.frame),
                                                              halfWidth,
                                                              halfHeight)
               
                                       withParent:self];
    _SWNode = [[QuadTreeNode alloc] initWithFrame: MKMapRectMake(MKMapRectGetMinX(self.frame),
                                                              MKMapRectGetMinY(self.frame) + halfHeight,halfWidth,
                                                              halfHeight)
                                       withParent:self];
    _SENode = [[QuadTreeNode alloc] initWithFrame: MKMapRectMake(MKMapRectGetMinX(self.frame) + halfWidth,
                                                              MKMapRectGetMinY(self.frame) + halfHeight,halfWidth,
                                                              halfHeight)
                                       withParent:self];
    _NENode = [[QuadTreeNode alloc] initWithFrame: MKMapRectMake(MKMapRectGetMinX(self.frame) + halfWidth,
                                                              MKMapRectGetMinY(self.frame),
                                                              halfWidth,
                                                              halfHeight)
                                       withParent:self];
}

-(void)findPointsForAverage:(NSMutableArray*)array {
    if(array.count == 3) {
        return;
    } else if(self.myPoint.point.x != self.frame.origin.x - 1){
        [array addObject:self.myPoint];
        QuadTreeNode *temp1 = _NWNode;
        QuadTreeNode *temp2 = _SWNode;
        QuadTreeNode *temp3 = _SENode;
        QuadTreeNode *temp4 = _NENode;
        [temp1 findPointsForAverage: array];
        [temp2 findPointsForAverage: array];
        [temp3 findPointsForAverage: array];
        [temp4 findPointsForAverage: array];
    }
}

@end

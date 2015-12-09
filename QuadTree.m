//
//  QuadTree.m
//  QuadTree
//
//  Created by Rob on 8/1/15.
//  Copyright (c) 2015 Rob. All rights reserved.
//

#import "QuadTree.h"
#import "QuadTreeNode.h"

@implementation QuadTree {
    MKMapRect maxFrame;
    QuadTreeNode *root;
}

-(instancetype)initWithFrame:(MKMapRect)frame {
    if(self = [super init]) {
        root = [QuadTreeNode new];
        root.frame = frame;
        root.myPoint = [QuadTreePoint new];
        root.myPoint.point = MKMapPointMake(self.frame.origin.x - 1, self.frame.origin.y - 1);    //set it outside of the frame
        root.pointCount = 0;
        root.area = MKMapRectGetHeight(self.frame) * MKMapRectGetWidth(self.frame);
    }
    return self;
}

-(NSMutableArray *)pointsWithFrame:(MKMapRect)frame withResolution:(double)resolution {
    return [root getPoints:[NSMutableArray new] withFrame:frame andResolution:resolution];
}

-(NSMutableArray *)quadTreeFramesInFrame:(MKMapRect)frame {
    return [root getFrames:[NSMutableArray new] inFrame:(MKMapRect)frame];
}


-(void)insertPoint:(MKMapPoint)aPoint {
    [root insertPoint:aPoint];
    
}


@end

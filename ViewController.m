//
//  ViewController.m
//  MapKitCluster
//
//  Created by Robert Payne on 8/5/15.
//  Copyright (c) 2015 Robert Payne. All rights reserved.
//

#import "ViewController.h"
#import "MapDataPoints.h"
#import "QuadTree.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MyMapView *mapView;
@property (nonatomic) QuadTree *quadTree;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    self.quadTree = [[QuadTree alloc]initWithFrame:MKMapRectWorld];
    for(MKPointAnnotation *point in [MapDataPoints mapDataPoints]) {
        [self.quadTree insertPoint:MKMapPointForCoordinate(point.coordinate)];
    }
    [self.mapView addAnnotations: [self.quadTree pointsWithFrame:_mapView.visibleMapRect withResolution: _mapView.visibleMapRect.size.width *12]];
//    NSLog(@"Width: %f", _mapView.visibleMapRect.size.width);
    MKPointAnnotation *position =[self.mapView.annotations objectAtIndex:0];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(position.coordinate, 1400, 1400);
    
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [self.mapView removeAnnotations:self.mapView.annotations];
}
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.mapView addAnnotations:[self.quadTree pointsWithFrame:_mapView.visibleMapRect withResolution: _mapView.visibleMapRect.size.width *12]];
//    NSLog(@"Width: %f", _mapView.visibleMapRect.size.width);
    NSLog(@"Number of points loaded to the map: %i", self.mapView.annotations.count);

}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    for(MKAnnotationView *av in views) {
        av.alpha = 0.0;
        CGPoint originalPosition = CGPointMake(av.center.x, av.center.y);
        av.center = CGPointMake(av.center.x,av.center.y-15);
        [UIView animateWithDuration:0.5f
                         animations:^(void){
                             av.center = originalPosition;
                             av.alpha = 1.0;
                         }
                         completion:^(BOOL finished){}];
    }
}

@end

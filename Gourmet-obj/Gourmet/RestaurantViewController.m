//
//  RestaurantViewController.m
//  Gourmet
//
//  Created by Alejandro Miragall Arnal on 14/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

#import "RestaurantViewController.h"
#import <Firebase/Firebase.h>
#import "Restaurant.h"

@interface RestaurantViewController ()

@end

@implementation RestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self loadRestaurant];
}


- (void) loadRestaurant {
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://tuenti-restaurants.firebaseio.com/restaurants"];
    NSLog(@"Opening Resto");
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot* child in snapshot.children) {
            Restaurant *rest = [[Restaurant alloc] init];
            [rest setName:child.value[@"name"]];
            [rest setDescription:child.value[@"description"]];
            [rest setAddress:child.value[@"address"]];
            [rest setPhoto:child.value[@"photo"]];
            [rest setLat:[child.value[@"lat"] doubleValue]];
            [rest setLon:[child.value[@"lon"] doubleValue]];
            NSLog(@"Object %@", rest);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

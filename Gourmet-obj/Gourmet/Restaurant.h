//
//  Restaurant.h
//  Gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * photo;
@property double lat;
@property double lon;

@end

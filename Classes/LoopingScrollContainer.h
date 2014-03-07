//
// Created by Marek Mościchowski on 12/01/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface LoopingScrollContainer : UIViewController
{

}

@property (nonatomic, strong) NSArray *controllers;

- (void)showViewControllerAtIndex:(NSUInteger)index;

@end
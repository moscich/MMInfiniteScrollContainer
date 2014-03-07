//
// Created by Marek Mościchowski on 12/01/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//


#import "ShowcaseDemoViewController.h"
#import "LoopingScrollContainer.h"
#import "UIImageView+LoremPixel.h"

@implementation ShowcaseDemoViewController
{
    LoopingScrollContainer *loopingScrollContainer;
}

- (void)viewDidLoad
{
    loopingScrollContainer = [[LoopingScrollContainer alloc] init];
    [((UIScrollView *)loopingScrollContainer.view) setPagingEnabled:YES];
    UIViewController *firstViewContoller = [[UIViewController alloc] init];
    firstViewContoller.view = [[UIImageView alloc] init];
    firstViewContoller.view.contentMode=UIViewContentModeScaleAspectFit;
    UIViewController *secondViewContoller = [[UIViewController alloc] init];
    secondViewContoller.view = [[UIImageView alloc] init];
    UIViewController *thirdViewContoller = [[UIViewController alloc] init];
    thirdViewContoller.view = [[UIImageView alloc] init];
    loopingScrollContainer.controllers = @[firstViewContoller, secondViewContoller, thirdViewContoller];
    loopingScrollContainer.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    loopingScrollContainer.view.frame = CGRectMake(
            self.view.frame.size.width*0.2,
            self.view.frame.size.height*0.2,
            self.view.frame.size.width*0.6,
            self.view.frame.size.height*0.6);
    [self addChildViewController:loopingScrollContainer];
    [self.view addSubview:loopingScrollContainer.view];


//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 100, 50)];
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Bob" forState:UIControlStateNormal];
//    [self.view addSubview:button];
}

- (void)button {
    [UIView animateWithDuration:2.0 animations:^
    {
        loopingScrollContainer.view.frame = CGRectMake(
                0,
                loopingScrollContainer.view.frame.origin.x,
                self.view.frame.size.width,
                loopingScrollContainer.view.frame.size.height/2);
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    for(UIViewController *controller in loopingScrollContainer.controllers)
    {
        if(((UIImageView *) controller.view).image == nil)
        {
            controller.view.frame = loopingScrollContainer.view.frame;
            [((UIImageView *) controller.view) getDummyImage];
        }
    }
}
@end
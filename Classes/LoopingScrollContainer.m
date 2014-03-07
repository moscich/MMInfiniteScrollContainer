//
// Created by Marek Mościchowski on 12/01/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//


#import "LoopingScrollContainer.h"

@interface LoopingScrollContainer () <UIScrollViewDelegate>
@end

@implementation LoopingScrollContainer
{
    NSMutableArray *orderedSubViews;
    CGSize beforeLayoutViewSize;
    CGPoint beforeContentOffset;
}

- (void)loadView
{
    [super loadView];
    self.view = [[UIScrollView alloc] init];
    ((UIScrollView *)self.view).delegate = self;
}

- (void)setControllers:(NSArray *)controllers
{
    _controllers = controllers;
    orderedSubViews = [[NSMutableArray alloc] init];

    for(int i = 0;i < self.controllers.count; i++)
    {
        UIViewController *controller = [self.controllers objectAtIndex:i];
        [orderedSubViews addObject:controller.view];
        controller.view.frame = self.view.frame;
        controller.view.frame = CGRectMake(i*self.view.frame.size.width, 0, controller.view.frame.size.width, controller.view.frame.size.height);
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
    }
    [self.view setNeedsLayout];
}

- (void)showViewControllerAtIndex:(NSUInteger)index
{
    UIViewController *childController = [self.controllers objectAtIndex:index];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    for(int i = 0;i < orderedSubViews.count; i++)
    {
        UIView *subView = [orderedSubViews objectAtIndex:i];
        subView.frame = self.view.frame;
        subView.frame = CGRectMake(i*self.view.frame.size.width, 0, subView.frame.size.width, subView.frame.size.height);
    }
    UIScrollView *scrollView = (UIScrollView *)self.view;

    CGFloat widthChangeScale = beforeLayoutViewSize.width!=0 ? beforeLayoutViewSize.width/self.view.frame.size.width : 1;
    if(widthChangeScale != 1)
    {
        scrollView.contentOffset = CGPointMake(beforeContentOffset.x/widthChangeScale,0);
    }

//    NSLog(@"Before  width %f, Current %f",beforeLayoutViewSize.width, self.view.frame.size.width);

    scrollView.contentSize = CGSizeMake(self.controllers.count*self.view.frame.size.width, self.view.frame.size.height);
//    NSLog(@"ILE = %f",scrollView.contentOffset.x/widthChangeScale);

    beforeContentOffset = scrollView.contentOffset;
    beforeLayoutViewSize = self.view.frame.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x < 0)
    {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x + self.view.frame.size.width, scrollView.contentOffset.y);
        orderedSubViews = [LoopingScrollContainer shiftArrayElementsRight:orderedSubViews];
    }
    if(scrollView.contentOffset.x > (self.controllers.count - 1)*self.view.frame.size.width)
    {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x - self.view.frame.size.width, scrollView.contentOffset.y);
        orderedSubViews = [LoopingScrollContainer shiftArrayElementsLeft:orderedSubViews];
    }
}

+ (NSMutableArray *)shiftArrayElementsRight:(NSMutableArray *)array
{
    NSObject *subViewMostToTheRight = [array lastObject];

    for(int i = (int)array.count -1; i > 0; i--)
    {
        [array replaceObjectAtIndex:(NSUInteger) i
                         withObject:[array objectAtIndex:(NSUInteger) i - 1]];
    }
    [array replaceObjectAtIndex:0 withObject:subViewMostToTheRight];

    return array;
}

+ (NSMutableArray *)shiftArrayElementsLeft:(NSMutableArray *)array
{
    NSObject *subViewMostToTheLeft = [array objectAtIndex:0];

    for(int i = 0; i < (int)array.count -1; i++)
    {
        [array replaceObjectAtIndex:(NSUInteger) i
                         withObject:[array objectAtIndex:(NSUInteger) i + 1]];
    }
    [array replaceObjectAtIndex:array.count-1 withObject:subViewMostToTheLeft];

    return array;
}

@end
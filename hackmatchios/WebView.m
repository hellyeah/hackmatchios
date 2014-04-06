//
//  WebView.m
//  hackmatchios
//
//  Created by David Fontenot on 4/5/14.
//  Copyright (c) 2014 Dave Fontenot. All rights reserved.
//

#import "WebView.h"

@implementation WebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.scalesPageToFit = YES;
    self.scrollView.delegate = self;
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
    scrollView.showsHorizontalScrollIndicator = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

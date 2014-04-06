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
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    /*
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.delegate = self;
    [self addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeLeft.delegate = self;
    [self addGestureRecognizer:swipeLeft];
     */
    
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //for some reason this way didn't recognize the swipe gesture for some startups
    //[scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
    
    //this way worked to disable horizontal scrolling
    [scrollView setContentSize: CGSizeMake(self.frame.size.width, self.scrollView.contentSize.height)];
    
    //getting rid of the horizontal scroll indicator since theres no horizontal scrolling
    scrollView.showsHorizontalScrollIndicator = NO;
}

/*
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"web view did start load");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //need to disable horizontal scrolling
    [self.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    NSLog(@"blah");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"web view load error");
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

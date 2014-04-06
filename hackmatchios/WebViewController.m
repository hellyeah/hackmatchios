//
//  WebViewController.m
//  BlogReader
//
//  Created by Amit Bijlani on 4/8/13.
//  Copyright (c) 2013 Amit Bijlani. All rights reserved.
//

#import "WebViewController.h"
#import "NSMutableArray_Shuffling.h"
#import <Apptimize/Apptimize.h>


@interface WebViewController () {
    NSInteger _previousPage;
    NSInteger _currentPage;
}

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadStartupsFromParse];
    
    //array of webviews
    self.webViews = [[NSMutableArray alloc] init];
    //NSLog(@"%@", self.startups);

    //[self initializeWebViews];
    
    self.scrollView.delegate = self;
    //setting constraints so that webview doesnt overlap with [top] and [bottom]
    //webviews automatically account for them
    /*
    NSDictionary *views = @{ @"web": scrollView, @"top": self.topLayoutGuide, @"bottom": self.bottomLayoutGuide };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[web]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[web]|" options:0 metrics:nil views:views]];
     */
    
    //**use webviews array by instantiating webview by webview
    //when someone hits next just throw away that webView and instantiate a new one to add to the queue
    
    //take the first 4, make 4 webviews
    //use queue and always be hiding all views but the first view and showing the first view in the queue
    
}

- (void)viewDidLayoutSubviews {
    self.scrollView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0);
}

- (void) loadStartupsFromParse {
    //load startups from parse
    PFQuery *query = [PFQuery queryWithClassName:@"sponsorSites"];
    [query setLimit:1000];
    [query whereKey:@"tags" equalTo:@"mobile"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            NSMutableArray *mutableObjects = [objects mutableCopy];
            [mutableObjects shuffle];
            self.startups = [[mutableObjects valueForKey:@"url"] mutableCopy];
            [self loadWebViewAtIndex:0];
            [self loadWebViewAtIndex:1];
            [self.scrollView setContentOffset:CGPointZero animated:NO];
            NSLog(@"%@", self.startups);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![self.scrollView isEqual:scrollView]) {
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height)];
        scrollView.showsHorizontalScrollIndicator = NO;
    } else {
        [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width, scrollView.frame.size.height)];
        scrollView.showsVerticalScrollIndicator = NO;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (![self.scrollView isEqual:scrollView])
        return;

    CGPoint newContentOffset = *targetContentOffset;
    NSInteger page = lround(newContentOffset.x / scrollView.frame.size.width);

    if (page != _currentPage) {
        if (page - 1 >= 0) {
            [self loadWebViewAtIndex:(page - 1)];
        }
        if (page + 1 < self.startups.count) {
            [self loadWebViewAtIndex:(page + 1)];
        }
    }

    _previousPage = _currentPage;
    _currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollView isEqual:scrollView]) {
        UIWebView *webView = self.webViews[_previousPage];
        webView.scrollView.contentOffset = CGPointZero;
    }
}

- (void)loadWebViewAtIndex:(NSInteger)index {
    if ((index == self.webViews.count) || ![self.webViews[index] isKindOfClass:[UIWebView class]]) {
        UIWebView *webView = [[UIWebView alloc] init];
        webView.scalesPageToFit = YES;
        webView.scrollView.delegate = self;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.startups[index]]];
        [webView loadRequest:request];

        CGSize scrollViewSize = self.scrollView.frame.size;
        webView.frame = CGRectMake(scrollViewSize.width * index, 0, scrollViewSize.width, scrollViewSize.height);
        webView.frame = UIEdgeInsetsInsetRect(webView.frame, self.scrollView.contentInset);
        [self.scrollView addSubview:webView];
        self.webViews[index] = webView;
        self.scrollView.contentSize = CGSizeMake(scrollViewSize.width * self.webViews.count, scrollViewSize.height);
    }
}

- (void)unloadWebViewAtIndex:(NSInteger)index {
    if (![self.webViews[index] isEqual:[NSNull null]]) {
        UIWebView *webView = self.webViews[index];
        [webView removeFromSuperview];
        self.webViews[index] = [NSNull null];
    }
}

//shift by popping first element from array
- (void) removeWebViewtoWebViews {
    [self.webViews removeObjectAtIndex:0];
}

//need to take webview as an input
- (void) inititializeGestures:(WebView *) webView {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.delegate = self;
    [webView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeLeft.delegate = self;
    [webView addGestureRecognizer:swipeLeft];
}

- (void) nextWebView {
    if (self.index >= self.startups.count - 1) {
        self.index = 0;
    } else {
        self.index++;
    }
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[self.startups objectAtIndex:self.index]];
	[self.webView loadRequest:urlRequest];
    //[self.webView loadRequest:urlRequest];

    NSLog(@"%@", [self.startups objectAtIndex:self.index]);
}

- (void) hellYeahNextWebView {
    //save interest interaction object
    PFObject *hellYeah = [PFObject objectWithClassName:@"interest"];
    //substitue with the email they enter at the beginning
    hellYeah[@"contactEmail"] = @"raj@rjvir.com";
    hellYeah[@"startupURL"] = [[self.startups objectAtIndex:self.index] absoluteString];
    [hellYeah saveInBackground];
    //then do nextWebView
    [self nextWebView];
}

- (IBAction)next:(UIBarButtonItem *)sender {
    //increment to the next startup
    //self.index++;
    //NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[self.startups objectAtIndex:self.index]];
	//[self.webView loadRequest:urlRequest];
    [self nextWebView];
}

- (IBAction)hellYeah:(UIBarButtonItem *)sender {
    //check if there is data cached for userEmail and userUrl
    //if there isn't, drop down a view that collects that data once and caches it

    //try one
    /*
    CGRect frame = YourView.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    
    frame.origin.x = 0; //
    pushView.frame = frame;
    self.YourView.frame = CGRectMake(250, 45, 500, 960);
    [UIView commitAnimations];
     */
    //try two
    /*
    MyModalViewController *targetController = [[[MyModalViewController alloc] init] autorelease];
    
    targetController.modalPresentationStyle = UIModalPresentationFormSheet;
    targetController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal; //transition shouldn't matter
    [self presentModalViewController:targetController animated:YES];
    
    targetController.view.superview.frame = CGRectMake(0, 0, 200, 200);//it's important to do this after
    
    presentModalViewController targetController.view.superview.center = self.view.center;
     */
    [self hellYeahNextWebView];

}

// MARK: - Gesture Recognizers
- (void)swipeRightAction:(UISwipeGestureRecognizer*)recognizer
{
    NSLog(@"swipe right");
    [self hellYeahNextWebView];
}

- (void)swipeLeftAction:(UISwipeGestureRecognizer*)recognizer
{
    NSLog(@"swipe left");
    [self nextWebView];
}
/*

- (IBAction)swipeRight:(id)sender {
    [self nextWebView];
}

- (IBAction)swipeLeft:(id)sender {
    [self nextWebView];
}
 */
@end

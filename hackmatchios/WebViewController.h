//
//  WebViewController.h
//  BlogReader
//
//  Created by Amit Bijlani on 4/8/13.
//  Copyright (c) 2013 Amit Bijlani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "WebView.h";

@interface WebViewController : UIViewController<UIWebViewDelegate, UIScrollViewDelegate> {

}

@property (strong, nonatomic) NSMutableArray *webViews;
@property (strong, nonatomic) WebView *webView;


//**Startup Data
//counter to keep track of which startup we are on
//we are shuffling startups not the index like we do in web -- index always starts from 0 and increments
//not sure what happens when we surpass the alotted index but we should either circle back around or notify user
@property NSUInteger index;
//array of startups we have to work with
@property (strong, nonatomic) NSMutableArray *startups;
//url attribute of each item in the startups array
@property (strong, nonatomic) NSURL *startupURL;

- (IBAction)next:(UIBarButtonItem *)sender;
- (IBAction)hellYeah:(UIBarButtonItem *)sender;

//**User Data
@property (strong, nonatomic) NSURL *userEmail;
@property (strong, nonatomic) NSURL *userURL;

@end

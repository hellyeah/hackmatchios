//
//  WebViewController.h
//  BlogReader
//
//  Created by Amit Bijlani on 4/8/13.
//  Copyright (c) 2013 Amit Bijlani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WebViewController : UIViewController

//counter
@property NSUInteger index;
@property (nonatomic, strong) NSMutableArray *startups;
@property (strong, nonatomic) NSURL *startupURL;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
//- (IBAction)next:(id)sender;
- (IBAction)nextWebView:(UIBarButtonItem *)sender;


@end

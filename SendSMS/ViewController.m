//
//  ViewController.m
//  SendSMS
//
//  Created by Vamshi Reddy on 6/19/15.
//  Copyright (c) 2015 Vamshi. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>


@interface ViewController ()

@end

@implementation ViewController
- (IBAction)tappedOnSendSMS:(id)sender {
        NSLog(@"Sending request.");
        
        // Common constants
        NSString *kTwilioSID = @"AC1af95fd1bead34c082aa5a8c842b332f";
        NSString *kTwilioSecret = @"2d95f11dd5aec00d865e64d33563353d";
        NSString *kFromNumber = @"+13173163054";
        NSString *kToNumber = @"+13177931773";
        NSString *kMessage = @"Hi%20there.";
        
        // Build request
        NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", kTwilioSID, kTwilioSecret, kTwilioSID];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        
        // Set up the body
        NSString *bodyString = [NSString stringWithFormat:@"From=%@&To=%@&Body=%@", kFromNumber, kToNumber, kMessage];
        NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSError *error;
        NSURLResponse *response;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        // Handle the received data
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSString *receivedString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
            NSLog(@"Request sent. %@", receivedString);
        }     
    }
    


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

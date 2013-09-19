//
//  SecondViewController.m
//  estereoplata
//
//  Created by Leonel Roberto Perea Trejo on 12/09/13.
//  Copyright (c) 2013 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
            
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)sendSMS:(NSString *)message recipientList:(NSArray *)recipents
{
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    messageController.recipients = recipents;
    messageController.body = message;
    
    [self presentViewController:messageController animated:YES completion:NULL];
}

- (IBAction)buttonPressed:(id)sender
{
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    [self sendSMS:@"ZER " recipientList:[NSArray arrayWithObjects:@"30500", NULL]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

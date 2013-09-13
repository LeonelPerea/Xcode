//
//  ViewController.m
//  camaraFotografica
//
//  Created by Leonel Roberto Perea Trejo on 24/10/12.
//  Copyright (c) 2012 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize bTomarFotoSuperior;
@synthesize bTomarFotoInferior;
@synthesize picker;
@synthesize superior;

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (superior) {
        [bTomarFotoSuperior setImage:image forState:UIControlStateNormal];
    }else{
        [bTomarFotoInferior setImage:image forState:UIControlStateNormal];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)camera1:(UIButton *)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    superior = TRUE;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)camera2:(UIButton *)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    superior = FALSE;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
}

-(IBAction)showPicker:(id)sender
{
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		[self displayComposerSheet];
	}
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields.
-(void)displayComposerSheet
{
	MFMailComposeViewController *pickerMail = [[MFMailComposeViewController alloc] init];
	pickerMail.mailComposeDelegate = self;
	
	[pickerMail setSubject:@"Foto Factura"];
	
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"iticleonel.len@gmail.com"];
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
	
	[pickerMail setToRecipients:toRecipients];
	//[pickerMail setCcRecipients:ccRecipients];
	//[pickerMail setBccRecipients:bccRecipients];
    
    //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	// Attach an image to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
    
    
    UIImage *image = [bTomarFotoSuperior imageForState:UIControlStateNormal];
    NSData *data = UIImagePNGRepresentation(image);
	[pickerMail addAttachmentData:data mimeType:@"image/png" fileName:@"fotoTr"];
    
    UIImage *image2 = [bTomarFotoInferior imageForState:UIControlStateNormal];
    NSData *data2 = UIImagePNGRepresentation(image2);
	[pickerMail addAttachmentData:data2 mimeType:@"image/png" fileName:@"fotoTc"];
	
	// Fill out the email body text
	NSString *emailBody = @"Mi factura!";
	[pickerMail setMessageBody:emailBody isHTML:NO];
    
	[self presentModalViewController:pickerMail animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    /*
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
	*/
}

#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
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

//
//  ViewController.h
//  camaraFotografica
//
//  Created by Leonel Roberto Perea Trejo on 24/10/12.
//  Copyright (c) 2012 Leonel Roberto Perea Trejo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *bTomarFotoSuperior;
@property (strong, nonatomic) IBOutlet UIButton *bTomarFotoInferior;
@property (strong, nonatomic) UIImagePickerController *picker;
@property BOOL superior;

- (IBAction)camera1:(UIButton *)sender;
- (IBAction)camera2:(UIButton *)sender;
-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;

@end

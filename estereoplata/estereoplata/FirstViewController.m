//
//  FirstViewController.m
//  estereoplata
//
//  Created by Leonel Roberto Perea Trejo on 12/09/13.
//  Copyright (c) 2013 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "FirstViewController.h"
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CFNetwork/CFNetwork.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)setButtonImageNamed:(NSString *)imageName
{
    /*
	if (!imageName)
	{
		imageName = @"playButton";
	}
	//[currentImageName autorelease];
	//currentImageName = [imageName retain];
	
	UIImage *image = [UIImage imageNamed:imageName];
	
	[button.layer removeAllAnimations];
	[button setImage:image forState:0];
    
	if ([imageName isEqual:@"loadingbutton.png"])
	{
		[self spinButton];
	}*/
}

//
// destroyStreamer
//
// Removes the streamer, the UI update timer and the change notification
//
- (void)destroyStreamer
{
	if (streamer)
	{
		[[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
        /*
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
		*/
		[streamer stop];
		//[streamer release];
		streamer = nil;
	}
}

//
// createStreamer
//
// Creates or recreates the AudioStreamer object.
//
- (void)createStreamer
{
	if (streamer)
	{
		return;
	}
    
	[self destroyStreamer];
	
	NSString *escapedValue = (NSString *)CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)@"Http://Zer.zuperdns.net:9650",
                                                                                                   NULL, NULL, kCFStringEncodingUTF8);
    
	NSURL *url = [NSURL URLWithString:escapedValue];
	streamer = [[AudioStreamer alloc] initWithURL:url];
	
    /*
	progressUpdateTimer =
    [NSTimer
     scheduledTimerWithTimeInterval:0.1
     target:self
     selector:@selector(updateProgress:)
     userInfo:nil
     repeats:YES];
     */
	[[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(playbackStateChanged:)
     name:ASStatusChangedNotification
     object:streamer];
}

//
// viewDidLoad
//
// Creates the volume slider, sets the default path for the local file and
// creates the streamer immediately if we already have a file at the local
// location.
//
- (void)viewDidLoad
{
	[super viewDidLoad];
	[self createStreamer];
    [streamer start];
    /*
	MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:volumeSlider.bounds];
	[volumeSlider addSubview:volumeView];
	[volumeView sizeToFit];
	[self setButtonImageNamed:@"playbutton.png"];
     */
}

//
// spinButton
//
// Shows the spin button when the audio is loading. This is largely irrelevant
// now that the audio is loaded from a local file.
//
- (void)spinButton
{
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    /*
	CGRect frame = [button frame];
	button.layer.anchorPoint = CGPointMake(0.5, 0.5);
	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
     */
	[CATransaction commit];
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];
    
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
    /*
	[button.layer addAnimation:animation forKey:@"rotationAnimation"];
    */
	[CATransaction commit];
    
}

//
// animationDidStop:finished:
//
// Restarts the spin animation on the button when it ends. Again, this is
// largely irrelevant now that the audio is loaded from a local file.
//
// Parameters:
//    theAnimation - the animation that rotated the button.
//    finished - is the animation finised?
//
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self spinButton];
	}
}

//
// buttonPressed:
//
// Handles the play/stop button. Creates, observes and starts the
// audio streamer when it is a play button. Stops the audio streamer when
// it isn't.
//
// Parameters:
//    sender - normally, the play/stop button.
//
- (IBAction)buttonPressed:(id)sender
{
    [self createStreamer];
    [streamer start];
    /*
	if ([currentImageName isEqual:@"playbutton.png"])
	{
		[downloadSourceField resignFirstResponder];
		
		[self createStreamer];
		[self setButtonImageNamed:@"loadingbutton.png"];
		[streamer start];
	}
	else
	{
		[streamer stop];
	}
     */
}

//
// sliderMoved:
//
// Invoked when the user moves the slider
//
// Parameters:
//    aSlider - the slider (assumed to be the progress slider)
//
- (IBAction)sliderMoved:(UISlider *)aSlider
{
	if (streamer.duration)
	{
		double newSeekTime = (aSlider.value / 100.0) * streamer.duration;
		[streamer seekToTime:newSeekTime];
	}
}

//
// playbackStateChanged:
//
// Invoked when the AudioStreamer
// reports that its playback status has changed.
//
- (void)playbackStateChanged:(NSNotification *)aNotification
{
	if ([streamer isWaiting])
	{
		[self setButtonImageNamed:@"loadingbutton.png"];
	}
	else if ([streamer isPlaying])
	{
		[self setButtonImageNamed:@"stopbutton.png"];
	}
	else if ([streamer isIdle])
	{
		[self destroyStreamer];
		[self setButtonImageNamed:@"playbutton.png"];
	}
}

//
// updateProgress:
//
// Invoked when the AudioStreamer
// reports that its playback progress has changed.
//
- (void)updateProgress:(NSTimer *)updatedTimer
{
    /*
	if (streamer.bitRate != 0.0)
	{
		double progress = streamer.progress;
		double duration = streamer.duration;
		
		if (duration > 0)
		{
			[positionLabel setText:
             [NSString stringWithFormat:@"Time Played: %.1f/%.1f seconds",
              progress,
              duration]];
			[progressSlider setEnabled:YES];
			[progressSlider setValue:100 * progress / duration];
		}
		else
		{
			[progressSlider setEnabled:NO];
		}
	}
	else
	{
		positionLabel.text = @"Time Played:";
	}
     */
}

//
// textFieldShouldReturn:
//
// Dismiss the text field when done is pressed
//
// Parameters:
//    sender - the text field
//
// returns YES
//
- (BOOL)textFieldShouldReturn:(UITextField *)sender
{
	[sender resignFirstResponder];
	[self createStreamer];
	return YES;
}

//
// dealloc
//
// Releases instance memory.
//
- (void)dealloc
{
	[self destroyStreamer];
    /*
	if (progressUpdateTimer)
	{
		[progressUpdateTimer invalidate];
		progressUpdateTimer = nil;
	}
     */
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
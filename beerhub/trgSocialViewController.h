//
//  trgSocialViewController.h
//  beerhub
//
//  Created by Teddy Guenin on 5/2/13.
//  Copyright (c) 2013 Teddy Guenin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface trgSocialViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)facebook:(id)sender;
- (IBAction)twitter:(id)sender;
- (IBAction)email:(id)sender;

@end

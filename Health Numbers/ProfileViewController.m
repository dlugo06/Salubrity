//
//  ProfileViewController.m
//  Health Numbers
//
//  Created by Alfonso Pintos on 5/2/15.
//  Copyright (c) 2015 Meme Menu. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.anonymousSwitch addTarget:self
                      action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
    
//    if ([self.title isEqual: @"ME"]) {
//        [self fetchUserData];
//    }
}


-(void) fetchUserData {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"facebook_id" equalTo:[self.userProfile objectForKey:@"facebook_id"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %@.", objects);
            // Do something with the found object        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (IBAction)submitButtonPress:(id)sender {
    [self postToParse];
}


-(void) postToParse {
    PFObject *userObject = [PFObject objectWithClassName:@"User"];
    userObject[@"facebook_id"] = [self.userProfile objectForKey:@"facebook_id"];
    userObject[@"first_name"] = [self.userProfile objectForKey:@"first_name"];

    if ([self.hpvSwitch isOn]) {
        userObject[@"hpv"] = @"true";
    } else {
        userObject[@"hpv"] = @"false";
    }
    
//    changed from chlamydia to herpes - did not change the button naming
    if ([self.chlamydiaSwitch isOn]) {
        userObject[@"herpes"] = @"true";
    } else {
        userObject[@"herpes"] = @"false";
    }
    
    if ([self.gonorrheaSwitch isOn]) {
        userObject[@"gonorrhea"] = @"true";
    } else {
        userObject[@"gonorrhea"] = @"false";
    }
    
    if ([self.hivSwitch isOn]) {
        userObject[@"hiv"] = @"true";
    } else {
        userObject[@"hiv"] = @"false";
    }

    if ([self.otherSwitch isOn]) {
        userObject[@"other"] = @"true";
    } else {
        userObject[@"other"] = @"false";
    }
    
    if ([self.anonymousSwitch isOn]) {
        userObject[@"anonymous"] = @"false";
    } else {
        userObject[@"anonymous"] = @"true";
    }
    
    [userObject saveInBackground];
}

- (void)stateChanged:(UISwitch *)switchState
{
    if ([switchState isOn]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Going Public"
                                                        message:@"Be aware by toggling this button you are choosing to publicily display your information."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end

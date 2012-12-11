//
//  User.h
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *UserKey = @"wf_user";

@interface User : NSObject {
    NSString *wf_username__;
    NSString *email__;
    NSString *zip__;
    NSInteger active_profile_id__;
    NSInteger access_level__;
    NSString *trial_end_date__;
    NSString *member_level_name__;
    Boolean show_ads__;
    Boolean show_ads_toggle__;
    Boolean can_ads_toggle__;
    NSInteger member_id__;
    NSInteger member_level__;
    NSInteger default_ads_toggle_state__;   //1,0
    NSString *trial_status__;
    NSString *trial_message__;
    NSInteger trial_days_left__;
    NSArray *messages__;
    NSInteger non_trial_member_level__;
    NSString *non_trial_member_level_name__;
    
    NSDate *trialEndDate__;
}

- (id)initWithDictionary:(NSDictionary *) dictionary;

@property (readonly) NSString *wf_username;
@property (readonly) NSString *email;
@property (readonly) NSString *zip;
@property (readonly) NSInteger active_profile_id;
@property (readonly) NSInteger access_level;
@property (readonly) NSString *trial_end_date;
@property (readonly) NSString *member_level_name;
@property (readonly) Boolean show_ads;
@property (readonly) Boolean show_ads_toggle;
@property (readonly) Boolean can_ads_toggle;
@property (readonly) NSInteger member_id;
@property (readonly) NSInteger member_level;
@property (readonly) NSInteger default_ads_toggle_state;   //1,0
@property (readonly) NSString *trial_status;
@property (readonly) NSString *trial_message;
@property (readonly) NSInteger trial_days_left;
@property (readonly) NSArray *messages;
@property (readonly) NSInteger non_trial_member_level;
@property (readonly) NSString *non_trial_member_level_name;

@property (readonly) NSDate *trialEndDate;

@end

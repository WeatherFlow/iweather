//
//  User.m
//  WeatherFlowApi
//
//  Created by Pantelis Zirinis on 29/11/2012.
//  Copyright (c) 2012 Pantelis Zirinis. All rights reserved.
//

#import "User.h"
#import "NSNull+WeatherFlowApiAdditions.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        wf_username__ = [dictionary objectForKey:@"wf_username"];
        email__ = [dictionary objectForKey:@"email"];
        zip__ = [dictionary objectForKey:@"zip"];
        active_profile_id__ = [[dictionary objectForKey:@"active_profile_id"] integerValue];
        access_level__ = [[dictionary objectForKey:@"access_level"] integerValue];
        trial_end_date__ = [dictionary objectForKey:@"trial_end_date"];
        member_level_name__ = [dictionary objectForKey:@"member_level_name"];
        show_ads__ = [[dictionary objectForKey:@"show_ads"] boolValue];
        show_ads_toggle__ = [[dictionary objectForKey:@"show_ads_toggle"] boolValue];
        can_ads_toggle__ = [[dictionary objectForKey:@"can_ads_toggle"] boolValue];
        member_id__ = [[dictionary objectForKey:@"member_id"] integerValue];
        member_level__ = [[dictionary objectForKey:@"member_level"] integerValue];
        default_ads_toggle_state__ = [[dictionary objectForKey:@"default_ads_toggle_state"] integerValue];
        trial_status__ = [dictionary objectForKey:@"trial_status"];
        trial_message__ = [dictionary objectForKey:@"trial_message"];
        trial_days_left__ = [[dictionary objectForKey:@"trial_days_left"] integerValue];
        messages__ = [dictionary objectForKey:@"messages"];
        non_trial_member_level__ = [[dictionary objectForKey:@"non_trial_member_level"] integerValue];
        non_trial_member_level_name__ = [dictionary objectForKey:@"non_trial_member_level_name"];
        trialEndDate__ = [dictionary objectForKey:@"trialEndDate"];
    }
    return self;    
}

#pragma mark Setter and Getter
//===========================================================
//  wf_username
//===========================================================
- (NSString *)wf_username
{
    return wf_username__;
}
//===========================================================
//  email
//===========================================================
- (NSString *)email
{
    return email__;
}
//===========================================================
//  zip
//===========================================================
- (NSString *)zip
{
    return zip__;
}
//===========================================================
//  active_profile_id
//===========================================================
- (NSInteger)active_profile_id
{
    return active_profile_id__;
}
//===========================================================
//  access_level
//===========================================================
- (NSInteger)access_level
{
    return access_level__;
}
//===========================================================
//  trial_end_date
//===========================================================
- (NSString *)trial_end_date
{
    return trial_end_date__;
}
//===========================================================
//  member_level_name
//===========================================================
- (NSString *)member_level_name
{
    return member_level_name__;
}
//===========================================================
//  show_ads
//===========================================================
- (Boolean)show_ads
{
    return show_ads__;
}
//===========================================================
//  show_ads_toggle
//===========================================================
- (Boolean)show_ads_toggle
{
    return show_ads_toggle__;
}
//===========================================================
//  can_ads_toggle
//===========================================================
- (Boolean)can_ads_toggle
{
    return can_ads_toggle__;
}
//===========================================================
//  member_id
//===========================================================
- (NSInteger)member_id
{
    return member_id__;
}
//===========================================================
//  member_level
//===========================================================
- (NSInteger)member_level
{
    return member_level__;
}
//===========================================================
//  default_ads_toggle_state
//===========================================================
- (NSInteger)default_ads_toggle_state
{
    return default_ads_toggle_state__;
}
//===========================================================
//  trial_status
//===========================================================
- (NSString *)trial_status
{
    return trial_status__;
}
//===========================================================
//  trial_message
//===========================================================
- (NSString *)trial_message
{
    return trial_message__;
}
//===========================================================
//  trial_days_left
//===========================================================
- (NSInteger)trial_days_left
{
    return trial_days_left__;
}
//===========================================================
//  messages
//===========================================================
- (NSArray *)messages
{
    return messages__;
}
//===========================================================
//  non_trial_member_level
//===========================================================
- (NSInteger)non_trial_member_level
{
    return non_trial_member_level__;
}
//===========================================================
//  non_trial_member_level_name
//===========================================================
- (NSString *)non_trial_member_level_name
{
    return non_trial_member_level_name__;
}
//===========================================================
//  trialEndDate
//===========================================================
- (NSDate *)trialEndDate
{
    return trialEndDate__;
}

@end

//
//  Siren_Action_Field.m
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import "SHMActionField.h"

@implementation SHMActionField

-(id) initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        self.name = data[@"name"];
        if ([data[@"type"] isEqualToString:@"hidden"]) {
            self.type = Siren_Field_Hidden;
        }
        else if ([data[@"type"] isEqualToString:@"hidden"]) {
            self.type = Siren_Field_Hidden;
        }
        else if ([data[@"type"] isEqualToString:@"text"]) {
            self.type = Siren_Field_Text;
        }
        else if ([data[@"type"] isEqualToString:@"search"]) {
            self.type = Siren_Field_Search;
        }
        else if ([data[@"type"] isEqualToString:@"tel"]) {
            self.type = Siren_Field_Tel;
        }
        else if ([data[@"type"] isEqualToString:@"url"]) {
            self.type = Siren_Field_Url;
        }
        else if ([data[@"type"] isEqualToString:@"email"]) {
            self.type = Siren_Field_Email;
        }
        else if ([data[@"type"] isEqualToString:@"password"]) {
            self.type = Siren_Field_Password;
        }
        else if ([data[@"type"] isEqualToString:@"datetime"]) {
            self.type = Siren_Field_Datetime;
        }
        else if ([data[@"type"] isEqualToString:@"date"]) {
            self.type = Siren_Field_Date;
        }
        else if ([data[@"type"] isEqualToString:@"month"]) {
            self.type = Siren_Field_Month;
        }
        else if ([data[@"type"] isEqualToString:@"week"]) {
            self.type = Siren_Field_Week;
        }
        else if ([data[@"type"] isEqualToString:@"time"]) {
            self.type = Siren_Field_Time;
        }
        else if ([data[@"type"] isEqualToString:@"datetime-local"]) {
            self.type = Siren_Field_Datetime_Local;
        }
        else if ([data[@"type"] isEqualToString:@"number"]) {
            self.type = Siren_Field_Number;
        }
        else if ([data[@"type"] isEqualToString:@"range"]) {
            self.type = Siren_Field_Range;
        }
        else if ([data[@"type"] isEqualToString:@"color"]) {
            self.type = Siren_Field_Color;
        }
        else if ([data[@"type"] isEqualToString:@"radio"]) {
            self.type = Siren_Field_Radio;
        }
        else if ([data[@"type"] isEqualToString:@"file"]) {
            self.type = Siren_Field_File;
        }
        else if ([data[@"type"] isEqualToString:@"image"]) {
            self.type = Siren_Field_Image;
        }
        else if ([data[@"type"] isEqualToString:@"reset"]) {
            self.type = Siren_Field_Reset;
        }
        else if ([data[@"type"] isEqualToString:@"button"]) {
            self.type = Siren_Field_Button;
        }
        else if ([data[@"type"] isEqualToString:@"hidden"]) {
            self.type = Siren_Field_Hidden;
        }
        
        if ([data objectForKey:@"value"] != nil && [[[[data objectForKey:@"value"] class] description] isEqualToString:@"__NSCFArray"]) {
            self.values = data[@"value"];
        } else if ([data objectForKey:@"value"] != nil) {
            self.value = data[@"value"];
        }
    }
    
    return self;
}

@end

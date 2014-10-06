//
//  Siren_Action_Field.h
//  Siren-Parser
//
//  Created by Matthew Dobson on 2/1/14.
//  Copyright (c) 2014 Matthew Dobson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Siren_Field_Type) {
    Siren_Field_Hidden,
    Siren_Field_Text,
    Siren_Field_Search,
    Siren_Field_Tel,
    Siren_Field_Url,
    Siren_Field_Email,
    Siren_Field_Password,
    Siren_Field_Datetime,
    Siren_Field_Date,
    Siren_Field_Month,
    Siren_Field_Week,
    Siren_Field_Time,
    Siren_Field_Datetime_Local,
    Siren_Field_Number,
    Siren_Field_Range,
    Siren_Field_Color,
    Siren_Field_Checkbox,
    Siren_Field_Radio,
    Siren_Field_File,
    Siren_Field_Submit,
    Siren_Field_Image,
    Siren_Field_Reset,
    Siren_Field_Button
};


@interface SHMActionField : NSObject

@property (nonatomic, retain) NSString *name;
@property Siren_Field_Type type;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) NSArray *values;


-(id) initWithDictionary:(NSDictionary *)data;

@end

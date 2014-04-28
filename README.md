##Siren parser for Objective-C

### Build Status
[![Build Status](https://travis-ci.org/mdobson/SHMKit.png?branch=master)](https://travis-ci.org/mdobson/SHMKit)

SHMKit is a Siren Hypermedia Library for iOS. It will allow you to perform actions, and navigate a Siren API with ease.

### Getting Started

Just drag and drop the SHMKit project into your iOS project. I'll get around to creating a more tidy library eventually.

### Reference

#### SHMParser

This represents the API entry point. Here you'll initialize your parser object with the root url and begin walking the API accordingly.

##### Methods

Initializes a siren root. The endpoint parameter should be the entry point for your API. Ideally this should be placed in an App Delegate if possible.
```-(id) initWithSirenRoot:(NSString*)endpoint;```

Retrieves the root of your API Asynchronously. Pass in the block to get the first entity of your API.
```-(void) retrieveRoot:(void (^)(NSError *err, SHMEntity* entity))block;```


#### SHMEntity

Represents a siren entity. 

##### Methods

Initialize a new Siren Entity with an NSData class. This is ideal for when you're making HTTP requests straight to the API.
```-(id) initWithData:(NSData *)data;```

Init a siren entity with a dictionary. If you want to do parsing yourself, or are constructing siren entities in a NSDictionary on your end use this method.
```-(id) initWithDictionary:(NSDictionary *)json;```

Async step to link relation in current entity. If relation isn't present then return error as first parameter to the block.
```-(void) stepToLinkRel:(NSString *)linkRel withCompletion:(void (^)(NSError *error, SHMEntity *entity))block;```

Get a specific siren action from the entity. If no action with that particular name is present return nil.
```-(SHMAction *) getSirenAction:(NSString *)name;```

#### SHMLink

Represents a siren link relation.

##### Methods

Initialize a link relation object with a dictionary. This is for post parsing of siren entity. Internal use really.
```-(id) initWithDictionary:(NSDictionary*)data;```

#### SHMAction

Represents a siren action.

##### Methods

Initialize a action object with a dictionary. This is for post parsing of siren entity. Internal use really.
```-(id) initWithDictionary:(NSDictionary *)data;```

Perform the action with specific parameters. If no parameters pass in nil. Actions are performed asynchronously so the block will be necessary to get the next step in the API.
```-(void)performActionWithFields:(NSDictionary *)fields andCompletion:(void (^)(NSError *, SHMEntity *))block;```

Perform the action with no parameters. Actions are performed asynchronously so the block will be necessary to get the next step in the API.
```-(void)performActionWithCompletion:(void (^)(NSError *, SHMEntity *))block;```

#### SHMActionField

Represents a single field in a siren action.

#### SHMConstants

Constants for internal use only.

#### SHMUrlHelper

Helper class for internal use only.

#### SHMHTTPHelper

Helper class for internal use only.

### Tests

Tests are written with the XCTest.framework. Simply open the test tab of the project after download and run the tests. They are all currently passing.

### Contributing

1. Fork
2. Create a new branch
3. Do your codes
4. Make a Pull Request

### License

Copyright 2014 Matthew Dobson and other contributors

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

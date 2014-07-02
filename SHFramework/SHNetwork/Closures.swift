//
//  Closures.swift
//  SHFramework
//
//  Created by Ankit Thakur on 11/06/14.
//  Copyright (c) 2014 Ankit Thakur. All rights reserved.
//

import Foundation

typealias  CompletionBlock = (responseData:NSMutableData) -> Void;
typealias  ErrorBlock = (error:NSError) -> Void;

/*
Declaration:

(Bool(^)(NSString *string1, NSString *string2))reverse
(reverse: (String, String) -> Bool)


How to use:

[self methodName:
    ^Bool(NSString *string1, NSString *string2) {
    return string1 > string2
    }
];

methodName({ (string1:String, string2:String) -> Bool in
    return string1 > string2
})

*/


/*

// As a local variable:

objective-c 

    NSString*(^foo)(NSString *bar) = ^NSString*(NSString *bar) {
        return [NSString stringWithFormat: @"Hello %@", bar];
    };

swift

    var foo = { (bar: String) -> String in
        return "Hello " + bar
    }

*/
/*
// As a property:

objective-c
    @property (nonatomic, copy) NSString*(^foo)(NSString *bar);

swift
    // a constant

    let baz = { (bar: String) -> String in
        return "Hello " + bar
    }
    
    // property
    var foo: String -> String = {
        get { return baz }
        set { baz = newValue; }
    }
*/


/*
// As method paramete and argument

objective-c
    // As a method parameter:

    - (void)takeBlock:(NSString*(^)(NSString *bar))foo;

    // As an argument to a method call:

    [self takeBlock:
        ^NSString*(NString *bar) {
            return [NSString stringWithFormat: @"Hello %@", bar]
        }
    ];


swift:

    // As a method parameter

    func takeClosure( foo: String -> String )

    // As an argument to a method call:

    takeClosure({ (bar: String) -> String in
        return "Hello " + bar
    })

*/

/*

// As a typedef:

typedef NSString*(^Foo)(NSString *bar);
Foo foo = ^NSString*(NSString *bar) {
    return [NSString stringWithFormat: @"Hello %@", bar];
};

// As a typealias (typedef equivalent):

typealias Foo = String -> String
var foo: Foo = { (bar: String) -> String in
    return "Hello " + bar
}

*/
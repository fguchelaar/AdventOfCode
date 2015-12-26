//
//  main.m
//  AdventOfCodeObjC
//
//  Created by Frank Guchelaar on 24-12-15.
//  Copyright © 2015 Frank Guchelaar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSString *input = @"3113322113";
        NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:@"(\\d)\\1*" options:NSRegularExpressionCaseInsensitive error:NULL];

        for (int i=1; i<=50; i++) {
            
            NSArray<NSTextCheckingResult *> *matches = [regEx matchesInString:input options:0 range:NSMakeRange(0, input.length)];

            // reset
            NSMutableString *newString = [[NSMutableString alloc] init];
            for (NSTextCheckingResult *match in matches) {
                char c = [input characterAtIndex:match.range.location];
                [newString appendFormat:@"%lu%c", (unsigned long)match.range.length, c];
            }
            input = newString;
            NSLog(@"Run #%i = %lu", i, (unsigned long)input.length);
            
        }
    }
    return 0;
}

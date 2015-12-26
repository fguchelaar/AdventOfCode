//: # Advent of Code - [Day 0](http://adventofcode.com/day/10)
import Foundation

//: way to slow in a Playground and even Swift. Therefor hacked it in Objective-c:

/*

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

*/
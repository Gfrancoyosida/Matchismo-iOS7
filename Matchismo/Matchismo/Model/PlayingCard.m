//
//  PlayingCard.m
//  Matchismo
//
//  Created by Gianfranco on 9/10/15.
//  Copyright (c) 2015 Gianfranco. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;


//overriding superclass method

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *card = [otherCards firstObject];
        
        if (self.rank == card.rank) {
            score = 4;
        } else if ([self.suit isEqualToString:card.suit]) {
            score = 1;
        }
    } else {
        for (int i = 0; i < 2; i++) {
            PlayingCard *card = otherCards[i];
            if (self.rank == card.rank) {
                score += 4;
            } else if ([self.suit isEqualToString:card.suit]) {
                score += 1;
            }
        }
    }
    
    return score;
}

- (void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *) suit {
    return _suit? _suit : @"?";
}

- (NSString *) contents {
    NSArray *ranks = [PlayingCard rankStrings];
    NSString *currentRank = ranks[self.rank];
    return [currentRank stringByAppendingString:self.suit];
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *)validSuits {
    return @[@"♥︎", @"♣︎", @"♠︎", @"♦︎"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}


@end

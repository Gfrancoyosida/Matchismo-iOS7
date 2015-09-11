//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Gianfranco on 9/10/15.
//  Copyright (c) 2015 Gianfranco. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (int rank = 1; rank < [PlayingCard maxRank]; rank++) {
                PlayingCard *playingCard = [[PlayingCard alloc] init];
                playingCard.rank = rank;
                playingCard.suit = suit;
                [self addCard:playingCard];
            }
        }
    }
    return self;
}

@end

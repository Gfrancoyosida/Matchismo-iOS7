//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Gianfranco on 9/11/15.
//  Copyright (c) 2015 Gianfranco. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

// declaring a Class Extension
@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
            }
        }
    }
    
    return self;
}

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (Card *) cardAtIndex:(NSInteger)index {
    return (index >= 0 && index < [self.cards count])? self.cards[index] : nil;
}

static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;

- (void) chooseCardAtIndex:(NSInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.matched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (!otherCard.isMatched && otherCard.isChosen) {
                    int scoreByMatch = [card match:@[otherCard]];
                    
                    if (scoreByMatch) {
                        self.score += scoreByMatch * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                        
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = false;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end

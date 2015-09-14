//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Gianfranco on 9/11/15.
//  Copyright (c) 2015 Gianfranco. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "PlayingCard.h"

// declaring a Class Extension
@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic, assign) GamesMode matchMode;
@property (nonatomic, readwrite) NSString *scoreMessage;

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
    self.matchMode = kDefaultMode;
    
    return self;
}

- (void)setMatchMode:(enum GamesMode)mode {
    _matchMode = mode;
}

- (NSMutableArray *) cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (NSMutableArray *) chosenCards {
    if (!_chosenCards) {
        _chosenCards = [[NSMutableArray alloc] init];
    }
    
    return _chosenCards;
}

- (Card *) cardAtIndex:(NSInteger)index {
    return (index >= 0 && index < [self.cards count])? self.cards[index] : nil;
}

static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;

- (void) chooseCardAtIndex:(NSInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableString *message = [[NSMutableString alloc] init];
    [message appendString:card.contents];
    
    if (!card.matched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
            for (Card *otherCard in self.cards) {
                if (!otherCard.isMatched && otherCard.isChosen && ![self.chosenCards containsObject:otherCard]) {
                    int scoreByMatch;
                    
                    [self.chosenCards addObject:otherCard];
                    if (self.matchMode == kThreeMode) {
                        if ([self.chosenCards count] > 1) {
                            scoreByMatch = [card match:self.chosenCards];
                        } else {
                            continue;
                        }
                    } else {
                        scoreByMatch = [card match:self.chosenCards];
                    }
                    
                    
                    if (scoreByMatch) {
                        self.score += scoreByMatch * MATCH_BONUS;
                        [message setString:@""];
                        
                        for (PlayingCard *chosenCard in self.chosenCards) {
                            chosenCard.matched = YES;
                            [message appendString:chosenCard.contents];
                        }
                        [message appendString:card.contents];
                        [message appendString:[NSString stringWithFormat:@"for %d points", scoreByMatch]];
                        card.matched = YES;
                        
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (PlayingCard *chosenCard in self.chosenCards) {
                            chosenCard.chosen = NO;
                            [message appendString:chosenCard.contents];
                        }
                        [message appendString:[NSString stringWithFormat:
                                                          @"don’t match! -%d point penalty!", MISMATCH_PENALTY]];
                    }
                    [self.chosenCards removeAllObjects];
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    self.scoreMessage = message;
}

- (void) formatScoreMessage {
    
}

@end

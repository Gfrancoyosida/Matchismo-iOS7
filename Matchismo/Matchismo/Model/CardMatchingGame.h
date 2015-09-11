//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Gianfranco on 9/11/15.
//  Copyright (c) 2015 Gianfranco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;
- (void) chooseCardAtIndex:(NSInteger) index;
- (Card *) cardAtIndex:(NSInteger) index;

@property (nonatomic, readonly) NSInteger score;

@end

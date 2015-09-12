//
//  ViewController.m
//  Matchismo
//
//  Created by Gianfranco on 9/10/15.
//  Copyright (c) 2015 Gianfranco. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

#pragma mark - Custom accesors

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [self createMatchingGame];
    }
    
    return _game;
}

- (PlayingCardDeck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *) createMatchingGame {
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
}

#pragma mark - Action methods

- (IBAction)touchCardButton:(UIButton *)sender {
    int index = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:index];
    [self updateUI];

}

- (IBAction)resetGameButton:(UIButton *)sender {
    self.game = [self createMatchingGame];
    [self updateUI];
}

#pragma mark - Private methods

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int index = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:index];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card]forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *) titleForCard:(Card *)card {
    return card.isChosen? card.contents : @"";
}

- (UIImage *) backgroundForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen? @"cardfront" : @"cardback"];
}


@end

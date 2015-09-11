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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCounter;
@property (strong, nonatomic) Deck *playingCardDeck;

- (PlayingCard *) playingCard;

@end

@implementation ViewController

- (Deck *) playingCardDeck {
    if (!_playingCardDeck) {
        _playingCardDeck = [[PlayingCardDeck alloc] init];
    }
    return _playingCardDeck;
}

- (void) setFlipsCounter:(int)flipsCounter {
    _flipsCounter = flipsCounter;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipsCounter];
}

- (IBAction)touchCardButton:(UIButton *)sender {

    if (sender.currentTitle.length) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipsCounter++;
    } else {
        Card *playingCard = [self playingCard];
        if (playingCard) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:playingCard.contents forState:UIControlStateNormal];
        }
        self.flipsCounter++;
    }
    

}

- (PlayingCard *) playingCard {
    return (PlayingCard *)[self.playingCardDeck drawRandomCard];
}


@end

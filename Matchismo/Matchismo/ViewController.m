//
//  ViewController.m
//  Matchismo
//
//  Created by Gianfranco on 9/10/15.
//  Copyright (c) 2015 Gianfranco. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipsCounter;

@end

@implementation ViewController

- (void) setFlipsCounter:(int)flipsCounter {
    _flipsCounter = flipsCounter;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipsCounter];
}

- (IBAction)touchCardButton:(UIButton *)sender {

    if (sender.currentTitle.length) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"A♠︎" forState:UIControlStateNormal];
    }
    
    self.flipsCounter++;
}


@end

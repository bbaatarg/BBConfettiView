//
//  ViewController.m
//  BBConfitte Example
//
//  Created by Bayarbaatar Gonchigsuren on 6/15/24.
//

#import "ViewController.h"
#import "BBConfettiView.h"

@interface ViewController ()

@property(nonatomic, strong) BBConfettiView* confettiView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"View controller");
    self.confettiView = [[BBConfettiView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
    self.confettiView.center = CGPointMake(self.view.center.x, self.view.center.y - 100.0);
    [self.view addSubview:self.confettiView];
    
    UIButton* startButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 180.0, 44.0)];
    [startButton setTitle:@"Start Confetti 🎉" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
    [startButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    startButton.layer.borderColor = [UIColor grayColor].CGColor;
    startButton.layer.borderWidth = 1.0;
    startButton.layer.cornerRadius = 8.0;
    [startButton addTarget:self action:@selector(startConfettiButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    startButton.center = self.view.center;
    
}

- (void)startConfettiButtonClicked{
    
    [self.confettiView startConfetti];
}

@end

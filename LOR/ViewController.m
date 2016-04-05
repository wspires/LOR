//
//  ViewController.m
//  LOR
//
//  Created by Wade Spires on 4/4/16.
//

#import "ViewController.h"

#include <stdlib.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) NSString *left;
@property (strong, nonatomic) NSString *right;

@end

@implementation ViewController
@synthesize button = _button;
@synthesize left = _left;
@synthesize right = _right;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.button.backgroundColor = [UIColor blackColor];
    self.left = @"←";
    self.right = @"→";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSString *title = @"Tap Screen";
    [self resizeButtonFontForTitle:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    int const randomNumber = arc4random_uniform(2);
    NSString * const direction = (randomNumber == 0) ? self.left : self.right;
    [self.button setTitle:direction forState:UIControlStateNormal];
    
    // Calculate the font size the first time only.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self resizeButtonFontForTitle:direction];
    });
}

- (void)resizeButtonFontForTitle:(NSString *)title
{
    CGFloat fontSize = [self fontSizeForText:title fontName:@"HelveticaNeue" view:self.button];
    [self.button setTitle:title forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

// Calculate the font size such that the text is as large as possible within the view.
- (CGFloat)fontSizeForText:(NSString *)text fontName:(NSString *)fontName view:(UIView *)view {
    // Iterate through font sizes until finding a size 1 too large and so use the next smaller size.
    CGFloat fontSize = 2.0;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    while (1)
    {
        [attributes setObject:[UIFont fontWithName:fontName size:fontSize] forKey:NSFontAttributeName];
        CGSize size = [text sizeWithAttributes:attributes];
        if (size.width >= view.frame.size.width
            || size.height >= view.frame.size.height)
        {
            --fontSize;
            break;
        }
        ++fontSize;
    }
    return fontSize;
}

@end

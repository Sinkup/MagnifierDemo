//
//  CHRenderView.m
//  Magnifier
//
//  Created by Chenhao on 14-2-25.
//  Copyright (c) 2014年 Chenhao. All rights reserved.
//

#import "CHRenderView.h"
#import "CHMagnifierView.h"

@interface CHRenderView ()

@property (strong, nonatomic) NSTimer *touchTimer;
@property (strong, nonatomic) CHMagnifierView *magnifierView;

@end

@implementation CHRenderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - custom method
- (void)showLoupe:(NSTimer *)timer
{
    [self.magnifierView makeKeyAndVisible];
}

#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.TouchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                       target:self
                                                     selector:@selector(showLoupe:)
                                                     userInfo:nil
                                                      repeats:NO];
    
    if (self.magnifierView == nil) {
        self.magnifierView = [[CHMagnifierView alloc] init];
        self.magnifierView.viewToMagnify = self.window;
    }
    
    self.magnifierView.pointToMagnify = [[touches anyObject] locationInView:self.window];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.magnifierView.hidden == NO) {
        self.magnifierView.pointToMagnify = [[touches anyObject] locationInView:self.window];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchTimer invalidate];
    [self.magnifierView setHidden:YES];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchTimer invalidate];
    [self.magnifierView setHidden:YES];
}

@end

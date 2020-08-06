//
//  ViewController.m
//  CoreAnimation-04
//
//  Created by tlab on 2020/8/6.
//  Copyright © 2020 yuanfangzhuye. All rights reserved.
//

#import "ViewController.h"
#import "TlabButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    TlabButton *btn = [TlabButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((width - 30) /2, (height - 130) / 2, 30, 130);
    [self.view addSubview:btn];
    
    [btn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"like_orange"] forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)likeButtonClick:(TlabButton *)sender
{
    sender.selected = !sender.selected;
    if (!sender.selected) {
        NSLog(@"取消点赞");
    }
    else {
        NSLog(@"点赞");
    }
}


@end

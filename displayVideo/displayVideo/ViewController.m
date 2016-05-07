//
//  ViewController.m
//  视频播放
//
//  Created by 1 on 16/5/6.
//  Copyright © 2016年 1. All rights reserved.
//

#import "ViewController.h"

#import <MediaPlayer/MediaPlayer.h>
@interface ViewController ()

@property(nonatomic,strong) MPMoviePlayerController *mpc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知监测视频播放完毕
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinishNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}
#pragma mark 通知绑定的方法
- (void)moviePlayerPlaybackDidFinishNotification:(NSNotification *)notification
{
    /**
     MPMovieFinishReasonPlaybackEnded,  播放结束
     MPMovieFinishReasonPlaybackError,  播放错误
     MPMovieFinishReasonUserExited      退出播放
     */
    
    //1. 获取通知结束的状态
    NSInteger movieFinishKey = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    
    //2. 根据状态不同来自行填写逻辑代码
    switch (movieFinishKey) {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"播放结束");
            
            // 进行视频切换 需要两步
            
            //1. 要想换视频, 就需要更换地址
            self.mpc.contentURL = [[NSBundle mainBundle] URLForResource:@"See you again.mp4" withExtension:nil];
            [self.mpc play];
            break;
            
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"播放错误");
            break;
            
        case MPMovieFinishReasonUserExited:
            NSLog(@"退出播放");
            
            // 如果是不带view的播放器, 那么播放完毕(退出/错误/结束)都应该退出
            [self.mpc.view removeFromSuperview];
            break;
            
        default:
            break;
    }
    
}


- (IBAction)moviePlayerController:(id)sender{
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Alizee_La_Isla_Bonita.mp4" withExtension:nil];
    self.mpc= [[MPMoviePlayerController alloc]initWithContentURL:url];
    
    //    self.mpc.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    self.mpc.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    
    [self.view addSubview:self.mpc.view];
    
    //规范写法，（最好写上），如果不写的话也可以，因为调用play方法时候会自动调用此方法
    [self.mpc prepareToPlay];
    
    [self.mpc play];
    //控制模式自己可以根据需求设置上看看效果
    /**
     MPMovieControlStyleNone,       // No controls
     MPMovieControlStyleEmbedded,   // Controls for an embedded view（默认）
     MPMovieControlStyleFullscreen, // Controls for fullscreen playback
     */
    self.mpc.controlStyle = MPMovieControlStyleEmbedded;
}


- (IBAction)moviePlayerViewController:(id)sender {
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Alizee_La_Isla_Bonita.mp4" withExtension:nil];
    MPMoviePlayerViewController *mp = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
//    [self presentViewController:mp animated:YES completion:nil];
    mp.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    [self.view addSubview:mp.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

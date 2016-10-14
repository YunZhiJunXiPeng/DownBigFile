//
//  ViewController.m
//  DownBigFile
//
//  Created by 云之君兮鹏 on 16/10/11.
//  Copyright © 2016年 小超人. All rights reserved.
//

#import "ViewController.h"
#import "PP_DownLoad.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#define weakObject(type) __weak typeof(type) weak##type = type

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *progressLable;
@property (nonatomic, copy) NSString *filePath;
@end

@implementation ViewController

NSString *const Video_UrlStr = @"http://flv2.bn.netease.com/videolib3/1610/11/sFJQl9103/HD/sFJQl9103-mobile.mp4";

- (void)viewDidLoad {
    [super viewDidLoad];

   
    
}

- (IBAction)startAction:(UIButton *)sender
{
    weakObject(self);
   
    [[PP_DownLoad sharePP_DownLoad] startDownLoad:Video_UrlStr WithStartBlock:^(NSString *filePath, NSInteger hasLoadLength, NSInteger totalLength) {
        _filePath = filePath;
         NSLog(@"开始下载-->%s--->%@",__func__,[NSThread currentThread]);
    } progressBlock:^(NSInteger hasLoadLength, NSInteger totalLength) {
        weakself.progressLable.text = [NSString stringWithFormat:@"已经下载  %.2f %%",(hasLoadLength/1.0  / totalLength * 100.0)];
        NSLog(@"进度条--->%s--->当前的线程--->%@",__func__,[NSThread currentThread]);
    } didCompleteBlock:^(NSError *error) {
         NSLog(@"完成--->%s--->当前的线程--->%@",__func__,[NSThread currentThread]);
    }];
    
}
- (IBAction)stopAction:(UIButton *)sender
{
    [[PP_DownLoad sharePP_DownLoad] stopDownLoad];
}


- (IBAction)playVideo:(UIButton *)sender
{

    NSString *caches =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:_filePath];
    NSURL*videoPathURL=[[NSURL alloc] initFileURLWithPath:filePath];
    
    AVPlayerViewController *avPlay = [[AVPlayerViewController alloc] init];
    avPlay.player = [[AVPlayer alloc] initWithURL:videoPathURL];
    [self presentViewController:avPlay animated:YES completion:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  PP_DownLoad.h
//  DownBigFile
//
//  Created by 云之君兮鹏 on 16/10/11.
//  Copyright © 2016年 小超人. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StartLoadBlock)(NSString *filePath, NSInteger hasLoadLength, NSInteger totalLength);
typedef void(^ProgressBlock)(NSInteger hasLoadLength, NSInteger totalLength);
typedef void(^CompleteBlock)(NSError *error);


@class PP_DownLoad;

@protocol PP_DownLoadDelegate <NSObject>

// 开始下载
- (void)pp_DownLoad:(PP_DownLoad *)pp_DownLoad
      startFilePath:(NSString *)filePath
      hasLoadLength:(NSInteger)hasLoadLength
        totalLength:(NSInteger)totalLength;

// 获取下载进度
- (void)pp_DownLoad:(PP_DownLoad *)pp_DownLoad
    progressCurrent:(NSInteger)currentLength
        totalLength:(NSInteger)totalLength;
// 下载完成
- (void)pp_DownLoad:(PP_DownLoad *)pp_DownLoad didCompleteWithError:(NSError *)error;
@end


@interface PP_DownLoad : NSObject

@property (nonatomic, weak) id<PP_DownLoadDelegate> delegate;
@property (nonatomic, copy) StartLoadBlock startBlock ; // 开始下载回调
@property (nonatomic, copy) ProgressBlock progressBlock ; // 更新数据回调
@property (nonatomic, copy) CompleteBlock competeBlock ;// 下载完成回调


// 单例构造方法
+ (instancetype)sharePP_DownLoad;


// 开始下载
- (void)startDownLoad:(NSString *)downLoadUrl;

// 开始下载包含 Block 的回调
- (void)startDownLoad:(NSString *)downLoadUrl
       WithStartBlock:(StartLoadBlock)startBlock
        progressBlock:(ProgressBlock)progressBlock
     didCompleteBlock:(CompleteBlock)competeBlock;


// 暂停下载
- (void)stopDownLoad;

@end

//
//  LCShareTool.m
//  BSProject
//
//  Created by Liu-Mac on 5/2/17.
//  Copyright © 2017 Liu-Mac. All rights reserved.
//

#import "LCShareTool.h"
#import "LCTopicItem.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation LCShareTool

+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType item:(LCTopicItem *)item vc:(UIViewController *)vc {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  item.smallImage;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"百思分享" descr:item.text thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = item.weixin_url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

@end
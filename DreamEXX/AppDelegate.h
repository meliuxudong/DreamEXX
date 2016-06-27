//
//  AppDelegate.h
//  DreamEXX
//
//  Created by LiYang on 16/6/25.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)CBCentralManager * bluManager;


@end


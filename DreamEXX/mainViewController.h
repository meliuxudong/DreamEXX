//
//  mainViewController.h
//  DreamEXX
//
//  Created by LiYang on 16/6/25.
//  Copyright © 2016年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface mainViewController : UIViewController<CBPeripheralDelegate,CBCentralManagerDelegate>
@property (nonatomic,strong)CBCharacteristic * on_off_Charac;
@property (nonatomic,strong)NSMutableArray * peripheralArr;
@property (nonatomic,strong)NSMutableArray * serverArr;
@property (nonatomic,strong)CBCentralManager * bluManager;
@property (nonatomic,strong)CBPeripheral * periheral;

@end

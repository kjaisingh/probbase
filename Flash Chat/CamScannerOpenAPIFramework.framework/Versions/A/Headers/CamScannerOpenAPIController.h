//
//  CamScannerOpenAPIController.h
//  UIPasetBoardTransferDataTest
//
//  Created by Felix Liu on 11/19/12.
//  Copyright (c) 2012 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const CamScannerLite;
extern NSString * const CamScanner;
extern NSString * const CamScannerPro;
extern NSString * const CamScannerHD;
extern NSString * const CamScannerHDPro;

extern NSString * const kReturnFileType;
extern NSString * const kReturnCode;
extern NSString * const kFileFormatJPG;
extern NSString * const kFileFormatPDF;

typedef enum
{
    CSOpenAPIFileFormatJPEG,
    CSOpenAPIFileFormatPDF
}CSOpenAPIFileFormat;

typedef enum
{
    CSOpenAPIControllerErrorCodeTimeExpired = 5003,
    CSOpenAPIControllerErrorCodeNotAuthed = 5004,
    CSOpenAPIControllerErrorCodeDeviceCapped = 5005,
    CSOpenAPIControllerErrorCodeEhanceModeNotSupported = 5006,
    CSOpenAPIControllerErrorCodeReachedLimitation = 5007,
    CSOpenAPIControllerErrorCodeUnreachable = 5008,
    CSOpenAPIControllerErrorCodeMustLogin = 5009,
    CSOpenAPIControllerErrorCodeDeviceIDError = 5010,
    CSOpenAPIControllerErrorCodeAppIDError = 5011,
    CSOpenAPIControllerErrorCodeAppKeyError = 5012,
    CSOpenAPIReturnSuccess = 6000
}CSOpenAPIReturnCode;

typedef enum
{
    CSOpenAPIVersion1_0
}CSOpenAPIVersion;

@interface CamScannerOpenAPIController : NSObject


+ (void) sendImage:(UIImage *)image toTargetApplication :(NSString *)targetApp appKey:(NSString *) appKey subAppKey:(NSString *) subAppKey;


+ (NSDictionary *) userInfoFromURL:(NSURL *)url andSourceApplication:(NSString *)sourceApp;

/**
 *  Used to get the image data from CamScanner
 *
 *  @param fileFormat the fileFormat parameter returned by the method userInfoFromURL andSourceApplication:appKey:
 *
 *  @return Image data of PDF file data
 */
+ (NSData *) getImageDataFromCamScannerWithFileFormat:(NSString *) fileFormat;

/**
 *  Used to check whether the sourceApplication is CamScanner
 *
 *  @param sourceApplication The sourceApplication your appDelagete received in the method - (BOOL)application:openURL:sourceApplication:annotation:
 *
 *  @return return YES if the it is returned from CamScanner
 */
+ (BOOL) isSourceApplicationCamScanner:(NSString *) sourceApplication;


/**
 *  Returns all avilable CamScanner App ID that installed in the device
 *
 *  @return All CamScanner app id
 */
+ (NSArray *) availableApplications;

/**
 *  Check whether CamScanner Free is installed in this device
 *
 *  @return YES means CamScanner Free is installed in this device, otherwise, returns NO
 */
+ (BOOL) canOpenCamScannerLite;


/**
 *  Check whether CamScanner+ is installed in this device
 *
 *  @return YES means CamScanner+ is installed in this device, otherwise, returns NO
 */
+ (BOOL) canOpenCamScannerPlus;

/**
 *  Check whether CamScanner Pro is installed in this device
 *
 *  @return YES means CamScanner Pro is installed in this device, otherwise, returns NO
 */
+ (BOOL) canOpenCamScannerPro;

/**
 *  Check whether CamScanner HD is installed in this device
 *
 *  @return YES means CamScanner HD is installed in this device, otherwise, returns NO
 */
+ (BOOL) canOpenCamScannerHD;

/**
 *  Check whether CamScanner HD Pro is installed in this device
 *
 *  @return YES means CamScanner HD Pro is installed in this device, otherwise, returns NO
 */
+ (BOOL) canOpenCamScannerHDPro;

@end

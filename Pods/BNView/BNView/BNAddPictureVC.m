//
//  BNAddPictureVC.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/27.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNAddPictureVC.h"

#import "BNGloble.h"
#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "UIApplication+Helper.h"

NSString *const kPicture_maxCount = @"kPicture_MaxCount";
NSString *const kPicture_allowCrop = @"kPicture_allowCrop";
NSString *const kPicture_currentVC = @"kPicture_currentVC";

@interface BNAddPictureVC ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, assign) NSInteger photoMaxCount;
@property (nonatomic, assign) BOOL allowCropImage;
@property (nonatomic, strong) UIViewController *parController;

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@end

@implementation BNAddPictureVC

+(instancetype)sharedInstance{
    static BNAddPictureVC *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BNAddPictureVC alloc]init];
        
    });
    return sharedInstance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static BNAddPictureVC *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.photoMaxCount = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPhotosAttDict:(NSDictionary *)attDict handler:(void(^)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSInteger maxCount))handler{
    self.blockView = handler;

    if (attDict) {
        self.photoMaxCount = [attDict[kPicture_maxCount] integerValue];;
        self.allowCropImage = [attDict[kPicture_allowCrop] boolValue];;
        self.parController = attDict[kPicture_currentVC];
    }
    [self addPhotos];
    
//    DDLog(@"%@",attDict);
}

#pragma mark - - 拍照与相册

- (void)addPhotos{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照不会调用viewWillDisappear方法所以此处清除数据
        [self goTakePhoto];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goPhotoLibrary];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self.parController presentViewController:alertController animated:YES completion:nil];
}

//去相册(第一步)
- (void)goPhotoLibrary{
    if ([UIApplication hasRightOfCameraUsage]) {
        [self pushTZImagePickerController];
        
    } else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 无权限 引导去开启
            UIApplication * application = UIApplication.sharedApplication;
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([application canOpenURL:url]) [application openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
        }]];
        [self.parController presentViewController:alertController animated:YES completion:nil];
        
    }
}
//去拍照(第一步)
- (void)goTakePhoto{
    
    if ([UIApplication hasRightOfCameraUsage]) {
        [self pushImagePickerController];
        
    } else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"无法访问相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 无权限 引导去开启
            UIApplication * application = UIApplication.sharedApplication;
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([application canOpenURL:url]) [application openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
        }]];
        [self.parController presentViewController:alertController animated:YES completion:nil];
        
    }
}
//去相册(第二步)
- (void)pushTZImagePickerController {
    if (self.photoMaxCount <= 0) {
        NSAssert(self.photoMaxCount > 0, @"图片选择数量不能为0");
        return;
    }
    TZImagePickerController *pickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:self.photoMaxCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
//        pickerVC.selectedAssets = ; // 设置目前已经选中的图片数组
    pickerVC.allowPickingOriginalPhoto = NO;
    pickerVC.allowPickingMultipleVideo = NO;
    pickerVC.isSelectOriginalPhoto = NO;
    pickerVC.sortAscendingByModificationDate = YES;
    
    pickerVC.allowPickingVideo = NO;
    pickerVC.allowPickingGif = NO;
    pickerVC.allowTakePicture = NO; // 在内部显示拍照按钮
    pickerVC.isStatusBarDefault = NO;
    
    [pickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.blockView(photos, assets, isSelectOriginalPhoto, self.photoMaxCount);
        
    }];
    [self.parController presentViewController:pickerVC animated:YES completion:nil];
}
//去拍照(第二步)
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        weakSelf.location = [locations firstObject];

    } failureBlock:^(NSError *error) {
        weakSelf.location = nil;

    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = sourceType;
        self.imagePickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self.parController presentViewController:self.imagePickerVC animated:YES completion:nil];
    } else {
        DDLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
//去拍照(第三步)
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [TZImageManager.manager savePhotoWithImage:image location:self.location completion:^(PHAsset *asset,NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                DDLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        //处理
                        if (self.allowCropImage) { // 允许裁剪,去裁剪
                            [self goCropImage:assetModel image:image];
                        }
                        else {
                            self.blockView(@[image], @[assetModel.asset], YES, self.photoMaxCount);
                            
                        }
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - - 裁剪图片
- (void)goCropImage:(TZAssetModel *)assetModel image:(UIImage *)image{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
        self.blockView(@[cropImage], @[asset], NO, self.photoMaxCount);
        
    }];
    imagePicker.needCircleCrop = NO;
    imagePicker.circleCropRadius = 200;
    [self.parController presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark - - layz

-(UIImagePickerController *)imagePickerVC{
    if (!_imagePickerVC) {
        _imagePickerVC = ({
            UIImagePickerController * pickerVC = [[UIImagePickerController alloc] init];
            pickerVC.delegate = self;
            // set appearance / 改变相册选择页的导航栏外观
            pickerVC.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
            pickerVC.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
            UIBarButtonItem *tzBarItem, *BarItem;
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
            
            NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
            [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
            
            pickerVC;
        });
        
    }
    return _imagePickerVC;
}

@end

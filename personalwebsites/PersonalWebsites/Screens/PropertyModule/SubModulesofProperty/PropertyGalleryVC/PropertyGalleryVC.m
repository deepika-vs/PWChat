//
//  PropertyGalleryVC.m
//  PersonalWebsites
//
//  Created by vectoscalar on 14/10/16.
//  Copyright © 2016 VectoScalar. All rights reserved.
//

#import "PropertyGalleryVC.h"
#import "PropertyGalleryCell.h"
#import "LargeImgViewController.h"

#define kActionSheetTakePhoto   @"Take Photo"
#define kActionSheetPickPhoto   @"Photo Library"
#define kActionSheetCancel      @"Cancel"
#define kCameraNotAvailMsg      @"Camera Not Available"

#define kPropertyGalleryCellKey   @"PropertyGalleryCell"
#define kLargeImgViewControllerID @"LargeImgViewController"

#define kNumberOfCellInARow     02
#define kCellHeight             200.0f

@interface PropertyGalleryVC ()<PropertyGalleryCellDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate>{
    CGFloat cellWidth;
    CGFloat cellHeight;
    
    NSInteger rowIndex;
    NSString *captionText;
}

@end


@implementation PropertyGalleryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add delegate for collection view
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    [self configureUI];
    
    [self calculateSizeForCell];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    rowIndex = -1;
    captionText = kEmptyStr;
    
    //Prepare data for property images gallery.
    [self preparePropertyGalleryData];
}



- (void) configureUI{
    //Create rith nav items.
    //[self createRightNavigationItem];
    
    //Register cell for property images gallery
    UINib *nib = [UINib nibWithNibName:kPropertyGalleryCellKey bundle:nil];
    [self.mCollectionView registerNib:nib forCellWithReuseIdentifier:kPropertyGalleryCellKey];
    
    //Create floating button.
    [self performSelector:@selector(createFloatingButton) withObject:nil afterDelay:0.01];
    
}



//Calculate cell width according to number of cell need to show.
- (void) calculateSizeForCell{
    
    if(kNumberOfCellInARow == 1){
        cellWidth = [UIScreen mainScreen].bounds.size.width - 20.0;
    }else{
        cellWidth = ([UIScreen mainScreen].bounds.size.width - 5.0 * (kNumberOfCellInARow + 1)) /kNumberOfCellInARow;
    }
    
    cellHeight = kCellHeight;
}



- (void) preparePropertyGalleryData{
    //TODO: It will replace with api.
    self.imagesList = [[NSMutableArray alloc] init];
    self.imgCaptionList = [[NSMutableArray alloc] init];
    
//    for(int i=0; i<5; i++){
//        UIImage *img = [UIImage imageNamed:@"TestImage.jpg"];
//        
//        [self.imagesList addObject:img];
//        [self.imgCaptionList addObject:[NSString stringWithFormat:@"CaptionText %d", i]];
//    }
}



//Create floating button to add a new image to gallery.
- (void)createFloatingButton
{
    UIButton *floatingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGRect btnFrame = kFloatingBtnFrame;
    
    btnFrame.origin.y = self.view.frame.size.height - (kFloatingButtonSize + 15);
    
    floatingButton.frame = btnFrame;
    
    floatingButton.backgroundColor = kNavColor;
    //Configre Font and Text
    
    [Utility addFAUIOnButton:floatingButton andFATitle:kCameraFA andColor:[UIColor whiteColor] andFont:20];

    [floatingButton addTarget:self action:@selector(floatingButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [Utility addShadowToFloatingButton:floatingButton];
    
    [self.view addSubview:floatingButton];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -mark CollectionView Delegate <Methods>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 01;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //Number of row will be same as number of images in section.
    NSInteger nImages = [self.imagesList count];
    
    if(nImages == 0){
        self.addImageMsgView.hidden = NO;
    }else{
        self.addImageMsgView.hidden = YES;
    }
    
    return nImages;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PropertyGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPropertyGalleryCellKey forIndexPath:indexPath];
    
    if(cell != nil){
        cell.cellImgView.image = [self.imagesList objectAtIndex:indexPath.row];
        cell.captionTextField.text = [self.imgCaptionList objectAtIndex:indexPath.row];
        //Add border to the cell.
        cell.layer.borderWidth = 1.0f;
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.delegate = self;
        cell.rowIndex = indexPath.row;
        
        //[cell addTabGestureToImage];
    }
    
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(cellWidth, cellHeight);
}


- (void)floatingButtonTapped
{
    NSLog(@"---Add new photo");
    
    [self userTappedImageView];
}


- (void)userTappedImageView
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:kActionSheetCancel destructiveButtonTitle:kActionSheetTakePhoto otherButtonTitles:kActionSheetPickPhoto,nil];
    popup.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [popup showInView:self.view];
}


#pragma mark - Image Pickcer Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            // picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,kUTTypeImage,nil];
            
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else
        {
            
            
            UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:kCameraNotAvailMsg message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altnot show];
            
        }
        
    } else if (buttonIndex == 1) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,kUTTypeImage,nil];
        
        picker.delegate = self;
        picker.editing = YES;
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSData * imagedata = UIImageJPEGRepresentation(image, 0.3);
    
    UIImage *ima = [UIImage imageWithData:imagedata];
    
    //Added new image to show
    [self.imagesList addObject:ima];
    [self.imgCaptionList addObject:kEmptyStr];
    
    [self.mCollectionView reloadData];
    
}


#pragma -mark PropertyGalleryCellDelegate <Methods>

- (void)deleteCollectionViewCellAt:(NSIndexPath *) indexPath {
    //Delete item from data.
    [self.imagesList removeObjectAtIndex: indexPath.row];
    [self.imgCaptionList removeObjectAtIndex: indexPath.row];
    
    //Delete item from collectionview.
    [self.mCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self.mCollectionView reloadData];
}



- (void) showImageInScrollView:(PropertyGalleryCell *) cell{
 
    LargeImgViewController *imageScrollView = [[LargeImgViewController alloc] initWithNibName:kLargeImgViewControllerID bundle:nil];
    
    imageScrollView.imgIndex = [self.mCollectionView indexPathForCell:cell].row;
    
    imageScrollView.imagesList = [[NSMutableArray alloc] initWithArray:self.imagesList];
    
    [self.navigationController pushViewController:imageScrollView animated:YES];
}



- (void)createRightNavItem{
    [(BaseViewController *)self.containerVC createRightNavigationItem:kSaveFA andSize:18];
}

- (void)showSaveCaptionButton{
    [(BaseViewController *)self.containerVC showRightNavigationItem];
}


- (void)hideSaveCaptionButton{
    [(BaseViewController *)self.containerVC hideRightNavigationItem];
}



- (void)updateCaptionLocalForImgCell:(PropertyGalleryCell *)cell{
    rowIndex = [self.mCollectionView indexPathForCell:cell].row;
    captionText = cell.captionTextField.text;
}


- (void)userTappedOnRightBarButton:(id) sender
{
    //TODO:: Update caption data list.
    [self.imgCaptionList replaceObjectAtIndex:rowIndex withObject:captionText];
    [self hideRightNavigationItem];
    
    [self resignFirstResponder];
}


@end

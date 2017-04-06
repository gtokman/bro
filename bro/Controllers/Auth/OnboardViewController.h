//
//  SignUpViewController.h
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnboardViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)signUpAction:(UIButton *)sender;
- (IBAction)pageControlAction:(UIPageControl *)sender;

@end

//
//  SignUpViewController.m
//  bro
//
//  Created by g tokman on 4/6/17.
//  Copyright © 2017 garytokman. All rights reserved.
//

#import "OnboardViewController.h"

@interface OnboardViewController ()

@end

@implementation OnboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"Prepare for segue");
}

- (IBAction)unwindSegue:(UIStoryboardSegue*)segue {
    NSLog(@"Unwind segue");
}

+ (OnboardViewController*)initOnboardViewControllerFromStoryboard {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
            instantiateViewControllerWithIdentifier:@"OnboardVC"];
}

#pragma mark - Actions

- (IBAction)loginAction:(UIButton *)sender {
    NSLog(@"Login Action");
}

- (IBAction)signUpAction:(UIButton *)sender {
    NSLog(@"Signup Action");
}

- (IBAction)pageControlAction:(UIPageControl *)sender {
    NSLog(@"Page Controll Action");
    CGFloat xOffset = (self.collectionView.bounds.size.width
                         * self.pageControl.currentPage);
    [self.collectionView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
}

#pragma mark - CollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnboardCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - CollectionViewLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat currentPage = (scrollView.contentOffset.x / scrollView.bounds.size.width);
    self.pageControl.currentPage = (NSInteger) currentPage;
}

@end


















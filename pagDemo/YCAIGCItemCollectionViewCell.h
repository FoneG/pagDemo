//
//  YCAIGCItemCollectionViewCell.h
//  YouCut
//
//  Created by FoneG on 04/09/2023.
//

#import <UIKit/UIKit.h>
#import <libpag/PAGView.h>
#import <libpag/PAGImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCAIGCItemCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) PAGView *pagView;
//@property (nonatomic, strong) PAGImageView *pagImageView;

- (void)startAnimating;
- (void)stopAnimating;
- (void)pauseAnimating;

@end

NS_ASSUME_NONNULL_END

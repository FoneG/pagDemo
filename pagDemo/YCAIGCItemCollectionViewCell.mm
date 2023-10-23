//
//  YCAIGCItemCollectionViewCell.m
//  YouCut
//
//  Created by FoneG on 04/09/2023.
//

#import "YCAIGCItemCollectionViewCell.h"
#import <Masonry.h>

#define UsePAGImageView

@implementation YCAIGCItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 2;
        self.contentView.clipsToBounds = YES;
        self.pagView = [[PAGView alloc] init];
        self.pagView.repeatCount = 0;
        [self.contentView addSubview:self.pagView];
        [self.pagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        self.label = [[UILabel alloc] init];
        self.label.textColor = UIColor.whiteColor;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(8);
        }];
    }
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    [self.pagView setPath:nil];
}

- (void)startAnimating{
    if(!self.pagView.isPlaying){
        [self.pagView play];
    }
}

- (void)stopAnimating{
    if(self.pagView.isPlaying){
        [self.pagView pause];
        [self.pagView setProgress:0]; /// 这行代码会造成掉帧
    }
}

- (void)pauseAnimating{
    if(self.pagView.isPlaying){
        [self.pagView pause];
    }
}

@end

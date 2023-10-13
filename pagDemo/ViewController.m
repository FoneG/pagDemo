//
//  ViewController.m
//  pagDemo
//
//  Created by FoneG on 13/10/2023.
//

#import "ViewController.h"
#import "XRWaterfallLayout.h"
#import "YCAIGCItemCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, XRWaterfallLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <NSDictionary *>*items;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aigc_config.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    self.items = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    XRWaterfallLayout *layout = [[XRWaterfallLayout alloc] init];
    layout.columnSpacing = 10;
    layout.rowSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.exclusiveTouch = YES;
    [self.collectionView registerClass:[YCAIGCItemCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(YCAIGCItemCollectionViewCell.class)];
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startPagViewAnimation];
}

#pragma mark - XRWaterfallLayoutDelegate

- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = self.items[indexPath.row];
//    return itemWidth / [item[@"width"] floatValue] * [item[@"height"] floatValue];
    
    /// 测试pagView错乱
    return itemWidth*1.3;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YCAIGCItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(YCAIGCItemCollectionViewCell.class) forIndexPath:indexPath];
    NSDictionary *item = self.items[indexPath.row];
    NSString *path = [[NSBundle mainBundle] pathForResource:item[@"cover"] ofType:nil];
    [cell.pagView setPath:path];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self startPagViewAnimation];
}


- (void)startPagViewAnimation{
    // 判断 indexPath 是否在可见的 indexPaths 数组中
    NSArray<NSIndexPath *> *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    [visibleIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YCAIGCItemCollectionViewCell *cell = (YCAIGCItemCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:obj];
        if(cell){
            CGRect cellRect = [self.collectionView layoutAttributesForItemAtIndexPath:obj].frame;
            CGRect visibleRect = self.collectionView.bounds;
            // 判断 cell 的 frame 是否完全包含在可见区域内
            BOOL play =  CGRectContainsRect(visibleRect, cellRect) || cellRect.origin.y < visibleRect.origin.y;
            if(play){
                [cell startAnimating];
            }else{
                [cell stopAnimating];
            }
        }
    }];
}

- (void)stopPagViewAnimation{
    // 判断 indexPath 是否在可见的 indexPaths 数组中
    NSArray<NSIndexPath *> *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    [visibleIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YCAIGCItemCollectionViewCell *cell = (YCAIGCItemCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:obj];
        if(cell){
            [cell stopAnimating];
        }
    }];
}

- (void)pausePagViewAnimation{
    // 判断 indexPath 是否在可见的 indexPaths 数组中
    NSArray<NSIndexPath *> *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
    [visibleIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YCAIGCItemCollectionViewCell *cell = (YCAIGCItemCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:obj];
        if(cell){
            [cell pauseAnimating];
        }
    }];
}

@end

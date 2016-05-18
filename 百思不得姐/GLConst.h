

#import <UIKit/UIKit.h>

typedef enum {
    GLTopicTypeAll = 1,
    GLTopicTypePicture = 10,
    GLTopicTypeWord = 29,
    GLTopicTypeVoice = 31,
    GLTopicTypeVideo = 41,
    
} GLTopicType;

/**
 *  精华－标题栏高度
 */
UIKIT_EXTERN CGFloat const GLTitlesViewH;
/**
 *  精华－标题栏Y
 */
UIKIT_EXTERN CGFloat const GLTitlesViewY;

/**
 *  精华－标题栏间距
 */
UIKIT_EXTERN CGFloat const GLTopicMargin;

/**
 *  精华－顶部文字高度
 */
UIKIT_EXTERN CGFloat const GLTopicCellTextY;

/**
 *  精华－底部工具栏高度
 */
UIKIT_EXTERN CGFloat const GLTopicCellBottomBarH;
/**
 *  精华－cell－图片帖子的最大高度
 */
UIKIT_EXTERN CGFloat const GLTopicCellPictureMaxH;

/**
 *  精华－cell－一单超出最大高度，图片帖子的固定高度
 */
UIKIT_EXTERN CGFloat const GLTopicCellPictureBreakH;

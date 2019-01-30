//
//  BNWebView.m
//  WHWebView
//
//  Created by hsf on 2018/5/11.
//  Copyright © 2018年 魏辉. All rights reserved.
//

#import "BNWebView.h"

#import "BNGloble.h"

@interface BNWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) UIRefreshControl *refreshControl;  //刷新
@property (nonatomic,strong) UIProgressView *progress;  //进度条
@property (nonatomic,strong) UIButton *reloadBtn;  //重新加载按钮

@end

@implementation BNWebView

#pragma mark --Dealloc
- (void)dealloc{
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_wkWebView stopLoading];
    _wkWebView.UIDelegate = nil;
    _wkWebView.navigationDelegate = nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupUI];
    [self loadRequest];

}

#pragma mark private Methods
- (void)setupUI{
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.wkWebView];
    [self addSubview:self.progress];
    [self addSubview:self.reloadBtn];
}

- (void)loadRequest {
    if (![self.urlString hasPrefix:@"http"]) {//容错处理 不要忘记plist文件中设置http可访问 App Transport Security Settings
        self.urlString = [NSString stringWithFormat:@"http://%@",self.urlString];
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [_wkWebView loadRequest:request];
}

- (void)wkWebViewReload{
    [_wkWebView reload];
}


#pragma mark 导航按钮
- (void)back:(UIBarButtonItem*)item {
    if ([_wkWebView canGoBack]) {
        [_wkWebView goBack];
    } else {

    }
}

#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _progress.progress = [change[@"new"] floatValue];
        if (_progress.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self->_progress.hidden = YES;
            });
        }
    }
}

#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _progress.hidden = NO;
    _wkWebView.hidden = NO;
    _reloadBtn.hidden = YES;
    // 看是否加载空网页
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //执行JS方法获取导航栏标题
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        DDLog(@"title:____%@",title);
        
    }];
    [_refreshControl endRefreshing];
    
}

// 返回内容是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
    webView.hidden = YES;
    _reloadBtn.hidden = NO;
}

#pragma mark UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    DDLog(@"message__%@",message);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    DDLog(@"msg__%@",message);

}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
}

#pragma mark WKScriptMessageHandler js 拦截 调用OC方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    DDLog(@"方法名:%@", message.name);
    DDLog(@"参数:%@", message.body);
    //    // 方法名
    //    NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
    //    SEL selector = NSSelectorFromString(methods);
    //    // 调用方法
    //    if ([self respondsToSelector:selector]) {
    //        [self performSelector:selector withObject:message.body];
    //    } else {
    //        DDLog(@"未实行方法：%@", methods);
    //    }
    
    if([message.name isEqualToString:@"jsCallOc"]){
        // do something
    }
}


#pragma mark -lazy load
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        // 设置WKWebView基本配置信息
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences = [[WKPreferences alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        configuration.selectionGranularity = YES;
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"jsCallOC"];
        
        if (self.jsString) {
            WKUserScript *jsString = [[WKUserScript alloc] initWithSource:self.jsString injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:NO];
            [userContentController addUserScript:jsString];
        }
        configuration.userContentController = userContentController;
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-0) configuration:configuration];
        // 设置代理
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 是否开启下拉刷新
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 && _canDownRefresh) {
            if (@available(iOS 10.0, *)) {
                _wkWebView.scrollView.refreshControl = self.refreshControl;
            } else {
                // Fallback on earlier versions
            }
        }
        // 添加进度监听
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
        
    }
    return _wkWebView;
}

- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(wkWebViewReload) forControlEvents:(UIControlEventValueChanged)];
    }
    return _refreshControl;
}

- (UIProgressView* )progress {
    if (!_progress) {
        self.progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 2)];
        _progress.progressTintColor = _loadingProgressColor?_loadingProgressColor:UIColor.greenColor;
    }
    return _progress;
}

- (UIButton *)reloadBtn{
    if (!_reloadBtn) {
        self.reloadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _reloadBtn.frame = CGRectMake(0, 0, 200, 140);
        _reloadBtn.center = self.center;
        [_reloadBtn setBackgroundImage:[UIImage imageNamed:@"loadingError"] forState:UIControlStateNormal];
        [_reloadBtn setTitle:@"网络异常，点击重新加载" forState:UIControlStateNormal];
        [_reloadBtn addTarget:self action:@selector(wkWebViewReload) forControlEvents:(UIControlEventTouchUpInside)];
        [_reloadBtn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        _reloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_reloadBtn setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        _reloadBtn.titleLabel.numberOfLines = 0;
        _reloadBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGRect rect = _reloadBtn.frame;
        rect.origin.y -= 100;
        _reloadBtn.frame = rect;
        _reloadBtn.hidden = YES;
    }
    return _reloadBtn;
}


@end

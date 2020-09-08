# HCLanguageSwitch
应用内切换语言国际化方案

使用前请先下载、运行并查看Demo。

## 【Demo演示】


![演示1](https://github.com/ZuoLuFei/DemoFigure/blob/master/HCLanguageSwitch演示动图/HCLanguageSwitch-1.gif)


/**********************************************************************/

## 【手动导入】

手动导入LanguageSwitch文件夹即可


/**********************************************************************/
## 方法说明

1. 在AppDelegate中初始化语言，默认是英语
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    /**
    初始化国际化为汉语，默认是英语
    注意：只在程序第一次启动初始化时才生效
    */
    HCLocalizableManager.share.initializeLanguage("zh-Hans")
    return true
}
```

2. 切换语言
```swift
// 切换语言，参数为bundleName
HCLocalizableManager.share.updateLanguage("en")
```

3. 业务中使用方式
```swift
/**
 文字国际化流程：
 1.导入LanguageSwitch文件夹内容到项目中
 2.创建Localizable.strings国际化文档，并将国际化文件导入其中，具体请移步Localizable.strings文件，关于Localizable.strings创建步骤请自行百度
 3.使用如下方式开始文字国际化
 */
func textLocalizeble() {
    // 使用方式一：对语言切换感知度低的界面，采用最近宏定义取值（如界面不是常驻界面，加载必刷新，对语言切换响应感知度极低）
    titleWordLabel.text = DEF_LOCALIZED_STRING(key: "first_inputName")
    changeLanuageBtn.setTitle(DEF_LOCALIZED_STRING(key: "first_changeLanguage") , for: .normal)
    contentTextField.placeholder = DEF_LOCALIZED_STRING(key: "first_name")
    // 字符串拼接
    currentLanguageLabel.text = String.init(format: DEF_LOCALIZED_STRING(key:"first_currentLanguage%@%@"), HCLocalizableResourcesFilter.share.currentLanguageName, DEF_LOCALIZED_STRING(key: "first_inputName"))
    
    // 使用方法二：对语言感知度高，采用分类属性方法，此方法通过关联技术，会根据语言切换立即感知，并且切换语言（如界面是常驻界面，如UITabbarController界面，切换语言不会刷新界面，但是对语言切换感知度高，需要采用分类属性方法）
    titleWordLabel.hc_Text = DEF_LOCALIZED_STRING(key: "first_inputName")
    changeLanuageBtn.hc_SetTitle("first_changeLanguage", for: .normal)
    contentTextField.hc_PlaceholderSwitch = "first_name"
    // 属性方法的字符串拼接
    currentLanguageLabel.hc_Text = "first_currentLanguage%@%@" + "&&&" + HCLocalizableResourcesFilter.share.currentLanguageName + "&&&" + "first_inputName"
   
    
    /// 使用方法三，在特殊情况需要传输字符时，需要手动监听语言更新，注意：参数使用&&&进行分割
    currentLanguageLabel.hc_Text = "first_currentLanguage%@%@" + "&&&" + HCLocalizableResourcesFilter.share.currentLanguageName + "&&&" + "first_inputName"
    contentTextField.localizableDidChange { [weak self] in
        self?.currentLanguageLabel.text = String.init(format: DEF_LOCALIZED_STRING(key:"first_currentLanguage%@%@"), HCLocalizableResourcesFilter.share.currentLanguageName, DEF_LOCALIZED_STRING(key: "first_inputName"))
    }
}

/**
图片国际化流程：
1.导入LanguageSwitch文件夹内容到项目中
2.导入需要国际化图片，并将国际化图片根据语言区配置到xxxx.plist中，具体参考此Demo中的LocalizableImage.plist文件，注意此处的根key一定要使用国际化文件中的bundle的简写，如英语的bundle名字是“en”，中文的bundle名字是"zh-Hans"
3.将图片统一Key配置到HCLocalizableImage中，方便读取
4.使用功能如下方法开始图片国际化
*/
func textLocalizebleImage() {
    // 使用方式一：对语言切换感知度低的界面，采用最近宏定义取值（如此界面不是常驻界面，加载必刷新，对语言切换响应感知度极低）
    currentImageView.image = DEF_LOCALIZED_IMAGE_STRING(key: HCLocalizableImage.App_Store.rawValue)
    
    // 使用方法二：对语言感知度高，采用分类属性方法，此方法通过关联技术，会根据语言切换立即感知，并且切换语言（如此界面是常驻界面，如UITabbarController界面，切换语言不会刷新界面，但是对语言切换感知度高，需要采用分类属性方法）
    currentImageView.hc_Image = HCLocalizableImage.App_Store.rawValue
}
```

/**********************************************************************/

## 【示例】

请下载、运行并查看Demo

/**********************************************************************/

## 【贡献】

如果您发现了bug或需要帮助，请打开一个issue或者提交一个pull request，十分感谢

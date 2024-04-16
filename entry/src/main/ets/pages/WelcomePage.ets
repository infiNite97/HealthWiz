import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'
import common from '@ohos.app.ability.common'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import router from '@ohos.router'

// 有透明度白色文本样式
@Extend(Text)
function opacityWhiteText(opacity: number, fontSize: number = 10) {
  .fontSize(fontSize)
  .opacity(opacity)
  .fontColor(Color.White)
}

const PREF_KEY = 'userPrivacyKey'

@Entry
@Component
struct WelcomePage {
  // 获取context
  context = getContext(this) as common.UIAbilityContext
  // 创建对话框
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    })
  })

  async aboutToAppear() {
  // 读取用户首选项
    let isAgree = await PreferenceUtil.getPreferenceValue(PREF_KEY, false)
  // 记录为同意则跳转首页，不同意则打开弹窗
    if (isAgree) {
      this.jumpToIndex()
    } else {
      this.controller.open()
    }

  }

  jumpToIndex() {
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/Index'
      })
    }, 2000)
  }

  onConfirm() {
    PreferenceUtil.putPreferenceValue(PREF_KEY,true)
    this.jumpToIndex()
  }

  exitApp() {
    // 退出App
    this.context.terminateSelf()
  }

  build() {
    Column({ space: 10 }) {

      Row() {

        Image($r('app.media.home_logo'))
          .width(280)
      }
      .layoutWeight(1)

      Column() {
        Image($r('app.media.home_slogan'))
          .width(300)
        Image($r('app.media.line'))
          .width(350)
          .height(30)
      }
      .padding({ bottom: 30 })

      Text('健康轻行App致力于在饮食控制方面为您提供健康管理')
        .opacityWhiteText(0.8)
      Row() {

        Text('健康轻行支持').opacityWhiteText(0.8, 12)
        Text('IPv6')
          .opacityWhiteText(0.8, 12)
          .border({ width: 1, color: Color.White, radius: 16 })
          .padding({ left: 5, right: 5 })
        Text('网络').opacityWhiteText(0.8, 12)
      }
      .padding({ bottom: 30 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.welcome_page_background'))
  }
}
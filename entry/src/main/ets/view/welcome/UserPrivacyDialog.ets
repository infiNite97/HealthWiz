  // 声明自定义对话框
@CustomDialog
export default struct UserPrivacyDialog {
  controller: CustomDialogController
  confirm: () => void
  cancel: () => void

  build() {

    Column({ space: 10 }) {

      Text($r('app.string.user_privacy_title'))
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Text($r('app.string.user_privacy_content'))
        .lineHeight(24)
      Button('同意')
        .width(150)
        .backgroundColor($r('app.color.primary_color'))
        .onClick(() => {
          this.confirm()
          this.controller.close()
        })
      Button('不同意')
        .width(150)
        .backgroundColor($r('app.color.lightest_primary_color'))
        .fontColor($r('app.color.light_gray'))
        .onClick(() => {
          this.cancel()
          this.controller.close()
        })
    }
    .width('100%')
    .padding(20)
  }
}
@Component
export default struct Mine {
  build() {
    Column({ space: 10 }) {

      Row() {
        Text('我的')
          .fontSize(20)
          .fontWeight(700)
      }
      .width('100%')
      .padding(10)

      Row({ space: 20 }) {
        Image($r('app.media.ic_user_portrait'))
          .width(40)
        Column() {
          Text('Kevin')
          Text('1297799431@qq.com')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('94%')
      .padding(10)
      .backgroundColor(Color.White)
      .borderRadius(18)
      .height(80)

      Column() {
        this.ItemBuilder($r('app.media.yingshifangan'), '饮食方案')
        Divider()
          .width('94%')
          .color($r('app.color.light_gray'))
          .strokeWidth(0.4)
          .padding({ left: 30 })
        this.ItemBuilder($r('app.media.shujuguanli'), '数据管理')
        Divider()
          .width('94%')
          .color($r('app.color.light_gray'))
          .strokeWidth(0.4)
          .padding({ left: 30 })
        this.ItemBuilder($r('app.media.caidanshezhi'), '菜单设置')
        Divider()
          .width('94%')
          .color($r('app.color.light_gray'))
          .strokeWidth(0.4)
          .padding({ left: 30 })
        this.ItemBuilder($r('app.media.guanyu'), '关于')
      }
      .width('94%')
      .padding(10)
      .backgroundColor(Color.White)
      .borderRadius(18)

      Blank()
      Button('退出登录')
        .width('90%')
        .backgroundColor($r('app.color.light_gray'))
        .fontColor('#fffc3217')
        .margin({ bottom: 30 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EDEDED')
  }

  @Builder
  ItemBuilder(icon: ResourceStr, label: string) {

    Column() {
      Row({ space: 8 }) {
        Image(icon)
          .width(24)
        Text(label)
          .fontSize(14)
          .fontWeight(500)
        Blank()
        Image($r('app.media.ic_public_arrow_right'))
          .width(20)
          .fillColor($r('app.color.light_gray'))
      }
      .width('100%')
      .padding({ top: 6, bottom: 6 })
    }
  }
}
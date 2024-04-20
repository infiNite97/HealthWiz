import router from '@ohos.router'
import ItemList from '../view/item/ItemList'
import ItemPanelHeader from '../view/item/ItemPanelHeader'
import ItemCard from '../view/item/ItemCard'
import NumberKeyboard from '../view/item/NumberKeyboard'

@Entry
@Component
struct ItemIndex {
  @State showPanel: boolean = false
  @State amount: number = 1
  @State value: string = ''

  onPanelShow() {
    this.amount = 1
    this.value = ''
    this.showPanel = true
  }

  build() {
    Column() {
      // 头部
      this.Header()
      // 列表
      ItemList({ showPanel: this.onPanelShow.bind(this) })
        .layoutWeight(1)
      // 底部面板
      Panel(this.showPanel) {
        // 顶部日期
        ItemPanelHeader()
        // 记录项卡片
        ItemCard({ amount: this.amount })
        // 数字键盘
        NumberKeyboard({ amount: $amount, value: $value })
        // 按钮
        Row({ space: 6 }) {
          Button('取消')
            .width(120)
            .backgroundColor($r('app.color.light_gray'))
            .type(ButtonType.Normal)
            .borderRadius(6)
            .onClick(() => {
              this.showPanel = false
            })
          Button('提交')
            .width(120)
            .backgroundColor($r('app.color.primary_color'))
            .type(ButtonType.Normal)
            .borderRadius(6)
            .onClick(() => {
              this.showPanel = false
            })
        }
      }
      .mode(PanelMode.Full)
      .dragBar(false)
      .backgroundMask($r('app.color.light_gray'))
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  Header() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(24)
        .onClick(() => {
          router.back()
        })
      Blank()
      Text('早餐').fontSize(18).fontWeight(600)
    }
    .height(32)
    .width('94%')
  }
}
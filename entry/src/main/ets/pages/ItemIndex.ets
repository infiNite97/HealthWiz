import router from '@ohos.router'
import ItemList from '../view/item/ItemList'
import ItemPanelHeader from '../view/item/ItemPanelHeader'
import ItemCard from '../view/item/ItemCard'
import NumberKeyboard from '../view/item/NumberKeyboard'
import RecordItem from '../viewmodel/RecordItem'
import RecordType from '../viewmodel/RecordType'
import { RecordTypeEnum, RecordTypes } from '../model/RecordTypeModel'
import RecordService from '../service/RecordService'

@Entry
@Component
struct ItemIndex {
  @State amount: number = 1
  @State value: string = ''
  @State item: RecordItem = null
  @State type: RecordType = RecordTypes[0]
  @State showPanel: boolean = false
  @State isFood: boolean = true

  onPanelShow(item: RecordItem) {
    this.amount = 1
    this.value = ''
    this.item = item
    this.showPanel = true
  }

  onPageShow() {
    // 获取跳转时的参数
    let params: any = router.getParams()
    // 获取点击时的饮食记录类型
    this.type = params.type
    this.isFood = this.type.id != RecordTypeEnum.WORKOUT
  }

  build() {
    Column() {
      // 头部
      this.Header()
      // 列表
      ItemList({ showPanel: this.onPanelShow.bind(this), isFood: this.isFood })
        .layoutWeight(1)
      // 底部面板
      Panel(this.showPanel) {
        // 顶部日期
        ItemPanelHeader()
        // 记录项卡片
        if (this.item) {
          ItemCard({ amount: this.amount, item: $item })
        }
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
              RecordService.insert(this.type.id, this.item.id, this.amount)
                .then((number) => {
                  console.log('testTag', '查询到:', number)
                  this.showPanel = false
                })
                .catch((err) => {
                  console.log('testTag', '查询失败', JSON.stringify(err))
                })
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
      Text(this.type.name).fontSize(18).fontWeight(600)
    }
    .height(32)
    .width('94%')
  }
}
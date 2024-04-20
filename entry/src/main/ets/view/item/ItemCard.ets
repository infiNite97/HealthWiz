import RecordItem from '../../viewmodel/RecordItem'

@Component
export default struct ItemCard {
  @Prop amount: number
  @Link item: RecordItem

  build() {
    Column({ space: 8 }) {
      // 图片
      Image(this.item.image)
        .width(150)
      // 名称
      Row() {
        Text(this.item.name)
          .fontWeight(600)
      }
      .backgroundColor($r('app.color.lightest_primary_color'))
      .padding({ top: 5, bottom: 5, left: 12, right: 12 })
      .borderRadius(18)

      Divider()
        .width('94%')
        .opacity(0.6)
      // 营养素
      Row({ space: 8 }) {
        this.NutrientInfo('热量(千卡)', this.item.calorie)
        if (this.item.id < 10000) {
          this.NutrientInfo('碳水(克)', this.item.carbon)
          this.NutrientInfo('蛋白质(克)', this.item.protein)
          this.NutrientInfo('脂肪(克)', this.item.fat)
        }

      }
      .width('94%')
      .justifyContent(FlexAlign.SpaceEvenly)

      Divider()
        .width('94%')
        .opacity(0.6)
      // 数量
      Row() {
        Column({ space: 4 }) {
          Text(this.amount.toFixed(1))
            .fontSize(50)
            .fontColor($r('app.color.primary_color'))
            .fontWeight(600)
          Divider()
            .color($r('app.color.primary_color'))
        }
        .width(150)

        Text(this.item.unit)
          .fontColor($r('app.color.light_gray'))
          .fontWeight(600)
      }
    }

  }

  @Builder
  NutrientInfo(label: string, value: number) {
    Column({ space: 8 }) {
      Text(label)
        .fontSize(14)
        .fontColor($r('app.color.light_gray'))
      Text((value * this.amount).toFixed(1))
        .fontSize(18)
        .fontWeight(700)
    }
  }
}
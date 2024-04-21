import RecordItem from '../../viewmodel/RecordItem'

@Builder
function NutrientInfo(label: string, value: number) {
  Column({ space: 8 }) {
    Text(label)
      .fontSize(14)
      .fontColor($r('app.color.light_gray'))
    Text((value * this.amount).toFixed(1))
      .fontSize(18)
      .fontWeight(700)
  }
}

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
        Column({ space: 8 }) {
          Text('热量(千卡)')
            .fontSize(14)
            .fontColor($r('app.color.light_gray'))
          Text((this.item.calorie * this.amount).toFixed(1))
            .fontSize(18)
            .fontWeight(700)
        }

        if (this.item.id < 10000) {
          Column({ space: 8 }) {
            Text('碳水(克)')
              .fontSize(14)
              .fontColor($r('app.color.light_gray'))
            Text((this.item.carbon * this.amount).toFixed(1))
              .fontSize(18)
              .fontWeight(700)
          }

          Column({ space: 8 }) {
            Text('蛋白质(克)')
              .fontSize(14)
              .fontColor($r('app.color.light_gray'))
            Text((this.item.protein * this.amount).toFixed(1))
              .fontSize(18)
              .fontWeight(700)
          }

          Column({ space: 8 }) {
            Text('脂肪(克)')
              .fontSize(14)
              .fontColor($r('app.color.light_gray'))
            Text((this.item.fat * this.amount).toFixed(1))
              .fontSize(18)
              .fontWeight(700)
          }
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
}
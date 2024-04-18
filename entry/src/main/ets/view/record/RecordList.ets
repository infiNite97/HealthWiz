@Extend(Text)
function grayText() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
export default struct RecordList {
  build() {

    List({ space: 10 }) {
      ForEach([1, 2, 3, 4, 5], (item) => {
        ListItem() {
          Column() {
            // 分组标题
            Row({ space: 4 }) {
              Image($r('app.media.ic_breakfast')).width(24)
              Text('早餐').fontSize(16).fontWeight(700)
              Text('建议423-592千卡').grayText()
              Blank()
              Text('190').fontSize(14).fontColor($r('app.color.primary_color'))
              Text('千卡').grayText()
              Image($r('app.media.ic_public_add_norm_filled'))
                .width(20)
                .fillColor($r('app.color.primary_color'))
            }
            .width('100%')

            // 记录列表
            List() {
              ForEach([1, 2], () => {
                ListItem() {
                  Row({ space: 6 }) {
                    Image($r('app.media.toast')).width(50)
                    Column({ space: 4 }) {
                      Text('全麦吐司').fontWeight(500)
                      Text('1片').grayText()
                    }

                    Blank()
                    Text('91千卡').grayText()
                  }
                  .width('100%')
                  .padding(6)
                }.swipeAction({ end: this.deleteButton.bind(this) })
              })
            }
            .width('100%')

          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(18)
          .padding(12)
        }
      })
    }
    .width('94%')
    .height('100%')
    .margin({ top: 10 })

  }

  @Builder
  deleteButton() {
    Row() {
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .fillColor(Color.Red)
        .margin(5)
    }
  }
}
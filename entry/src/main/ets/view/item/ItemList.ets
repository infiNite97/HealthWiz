@Component
export default struct ItemList {
  build() {
    Tabs() {
      TabContent() {
        this.TabContentBuilder()
      }
      .tabBar('全部')

      TabContent() {
        this.TabContentBuilder()
      }
      .tabBar('主食')

      TabContent() {
        this.TabContentBuilder()
      }
      .tabBar('果蔬')
    }
    .width('94%')
    .height('100%')
  }

  @Builder
  TabContentBuilder() {
    List({ space: 10 }) {
      ForEach([1, 2, 3, 4, 5, 6], () => {
        ListItem() {
          Row({ space: 6 }) {
            Image($r('app.media.toast')).width(50)
            Column({ space: 4 }) {
              Text('全麦吐司').fontWeight(500)
              Text('1片').fontSize(14).fontColor($r('app.color.light_gray'))
            }

            Blank()
            Image($r('app.media.ic_public_add_norm_filled'))
              .width(18)
              .fillColor($r('app.color.primary_color'))
          }
          .width('100%')
          .padding(6)
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}
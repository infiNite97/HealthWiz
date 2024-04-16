import WenxinAI from '../view/ai/WenxinAI'
import RecordIndex from '../view/record/RecordIndex'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  @Builder
  TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number) {
    Column({ space: 8 }) {
      Image(image)
        .width(22)
        .fillColor(this.currentIndex === index ? $r('app.color.primary_color') : $r('app.color.gray'))
      Text(title)
        .fontSize(14)
        .fontColor(this.currentIndex === index ? $r('app.color.primary_color') : $r('app.color.gray'))
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {

      TabContent() {
        RecordIndex()
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_record'), $r('app.media.record'), 0))

      TabContent() {
        WenxinAI()
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_assistant'), $r('app.media.ai'), 1))

      TabContent() {
        Text('我的页面')
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_user'), $r('app.media.mine'), 2))

    }
    .width('100%')
    .height('100%')
    .onChange(index => this.currentIndex = index)
  }
}
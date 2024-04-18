import router from '@ohos.router'
import ItemList from '../view/item/ItemList'

@Entry
@Component
struct ItemIndex {
  @State message: string = 'Hello World'

  build() {
    Column() {
      this.Header()
      ItemList()
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
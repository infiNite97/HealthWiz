import ItemModel from '../../model/ItemModel'
import GroupInfo from '../../viewmodel/GroupInfo'
import ItemCategory from '../../viewmodel/ItemCategory'
import RecordItem from '../../viewmodel/RecordItem'

@Component
export default struct ItemList {
  showPanel: (item: RecordItem) => void
  @Prop isFood: boolean

  build() {
    Tabs() {
      TabContent() {
        this.TabContentBuilder(ItemModel.list(this.isFood))
      }
      .tabBar('全部')

      ForEach(ItemModel.listItemGroupByCategory(this.isFood), (group: GroupInfo<ItemCategory, RecordItem>) => {
        TabContent() {
          this.TabContentBuilder(group.items)
        }
        .tabBar(group.type.name)
      })

    }
    .width('94%')
    .height('100%')
    .barMode(BarMode.Scrollable)
  }

  @Builder
  TabContentBuilder(items: RecordItem[]) {
    List({ space: 10 }) {
      ForEach(items, (item: RecordItem) => {
        ListItem() {
          Row({ space: 6 }) {
            Image(item.image).width(50)
            Column({ space: 4 }) {
              Text(item.name).fontWeight(500)
              Text(`${item.calorie}千卡/${item.unit}`).fontSize(14).fontColor($r('app.color.light_gray'))
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
            Image($r('app.media.ic_public_add_norm_filled'))
              .width(18)
              .fillColor($r('app.color.primary_color'))
          }
          .width('100%')
          .padding(6)
        }
        .onClick(() => this.showPanel(item))
      })
    }
    .width('100%')
    .height('100%')
  }
}
import RecordService from '../../service/RecordService'
import GroupInfo from '../../viewmodel/GroupInfo'
import RecordType from '../../viewmodel/RecordType'
import RecordVO from '../../viewmodel/RecordVO'
import router from '@ohos.router'
import RecordModel from '../../model/RecordModel'
import DateUtil from '../../common/utils/DateUtil'

@Extend(Text)
function grayText() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
export default struct RecordList {
  @Consume @Watch('handleRecordsChange') records: RecordVO[]
  @State groups: GroupInfo<RecordType, RecordVO>[] = []
  @StorageProp('selectedDate') @Watch('update') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  handleRecordsChange() {
    this.groups = RecordService.calculateGroupInfo(this.records)
  }

  async update() {
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
    this.handleRecordsChange()
  }

  build() {

    List({ space: 10 }) {
      ForEach(this.groups, (group: GroupInfo<RecordType, RecordVO>) => {
        ListItem() {
          Column() {
            // 分组标题
            Row({ space: 4 }) {
              Image(group.type.icon).width(24)
              Text(group.type.name).fontSize(16).fontWeight(700)
              Text(`建议${group.type.min}-${group.type.max}千卡`).grayText()
              Blank()
              Text(group.calorie.toFixed(0)).fontSize(14).fontColor($r('app.color.primary_color'))
              Text('千卡').grayText()
              Image($r('app.media.ic_public_add_norm_filled'))
                .width(20)
                .fillColor($r('app.color.primary_color'))
            }
            .width('100%')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/ItemIndex',
                params: { type: group.type }
              })
            })

            // 记录列表
            List() {
              ForEach(group.items, (item: RecordVO) => {
                ListItem() {
                  Row({ space: 6 }) {
                    Image(item.recordItem.image).width(50)
                    Column({ space: 4 }) {
                      Text(item.recordItem.name).fontWeight(500)
                      Text(`${item.amount}${item.recordItem.unit}`).grayText()
                    }

                    Blank()
                    Text(`${item.calorie.toFixed(0)}千卡`).grayText()
                  }
                  .width('100%')
                  .padding(6)
                }
                .swipeAction({ end: this.deleteButton(item.id) })
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
  deleteButton(id: number) {
    Row() {
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .fillColor(Color.Red)
        .margin(5)
    }
    .onClick(() => {
      RecordModel.deleteById(id)
      this.update()
    })
  }
}

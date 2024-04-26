import router from '@ohos.router'
import DateUtil from '../common/utils/DateUtil'
import RecordService from '../service/RecordService'
import RecordVO from '../viewmodel/RecordVO'

@Entry
@Component
struct SearchPage {
  val: string = router.getParams()['val']
  // val: string ='val'
  @State searchs: RecordVO[][] = []
  @State selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  async onPageShow() {
    this.searchs = await RecordService.queryRecordByName(this.val, this.selectedDate)
  }

  build() {
    Column({ space: 8 }) {
      Row({ space: 8 }) {

        Search({ value: this.val })
          .textFont({ size: 18 })
          .copyOption(CopyOptions.LocalDevice)
          .width('94%')
          .onSubmit((val) => {
            this.val = val
          })
      }
      .padding({ top: 50 })

      List({ space: 8 }) {
        ForEach(this.searchs, (search: RecordVO[]) => {
          ForEach(search, (item: RecordVO) => {
            ListItem() {
              Row({ space: 6 }) {
                Image(item.recordItem.image)
                  .width(60)
                  .borderRadius(10)
                Column({ space: 4 }) {
                  Text(item.recordItem.name).fontWeight(500)
                  Text(`${item.amount}${item.recordItem.unit}`)
                    .fontSize(14)
                    .fontColor($r('app.color.light_gray'))
                }

                Blank()
                Column({ space: 8 }) {
                  Text(`${(item.amount * item.calorie).toFixed(0)}千卡`)
                    .fontSize(14)
                    .fontColor($r('app.color.light_gray'))
                  Text(DateUtil.formatDate(item.createTime))
                    .fontSize(12)
                    .fontColor($r('app.color.tab_default'))
                }
                .padding({ top: 24 })
              }
              .width('100%')
              .backgroundColor(Color.White)
              .borderRadius(10)
              .padding(10)
            }

          })
        })
      }
      .width('100%')

      Blank()
      Row() {
        Text('*默认仅展示三年内的数据')
          .fontSize(10)
          .fontColor($r('app.color.light_gray'))
      }.padding(10)
    }
    .height('100%')
    .width('100%')

  }
}
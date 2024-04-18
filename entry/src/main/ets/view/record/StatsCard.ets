import DateUtil from '../../common/utils/DateUtil'
import DatePickDialog from './DatePickDialog'

@Component
export default struct StatsCard {

  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  controller: CustomDialogController = new CustomDialogController({
    builder: DatePickDialog({ selectedDate: new Date(this.selectedDate) })
  })

  build() {
    Column() {
      Row() {
        Text(DateUtil.formatDate(this.selectedDate))
          .fontColor($r('app.color.secondary_color'))
        Image($r('app.media.ic_public_spinner'))
          .width(20)
          .fillColor($r('app.color.secondary_color'))
      }
      .padding(10)
      .onClick(()=>{this.controller.open()})

    }
    .width('94%')
    .backgroundColor($r('app.color.stats_title_bgc'))
    .borderRadius(18)
  }
}
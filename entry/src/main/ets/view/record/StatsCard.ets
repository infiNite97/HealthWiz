import DateUtil from '../../common/utils/DateUtil'
import CalorieStats from './CalorieStats'
import DatePickDialog from './DatePickDialog'
import NutrientStats from './NutrientStats'

@Component
export default struct StatsCard {

  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())

  controller: CustomDialogController = new CustomDialogController({
    builder: DatePickDialog({ selectedDate: new Date(this.selectedDate) })
  })

  build() {
    // 日期信息
    Column() {
      Row() {
        Text(DateUtil.formatDate(this.selectedDate))
          .fontColor($r('app.color.secondary_color'))
        Image($r('app.media.ic_public_spinner'))
          .width(20)
          .fillColor($r('app.color.secondary_color'))
      }
      .width('100%')
      .padding(10)
      .onClick(()=>{this.controller.open()})
      // 统计信息
      Swiper(){
        CalorieStats()
        NutrientStats()
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(18)
      .indicatorStyle({selectedColor:$r('app.color.primary_color')})
    }
    .width('94%')
    .backgroundColor($r('app.color.stats_title_bgc'))
    .borderRadius(18)
  }
}
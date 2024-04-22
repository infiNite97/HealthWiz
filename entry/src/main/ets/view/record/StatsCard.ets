import BreakpointConstants from '../../common/constants/BreakpointConstants'
import DateUtil from '../../common/utils/DateUtil'
import RecordService from '../../service/RecordService'
import RecordVO from '../../viewmodel/RecordVO'
import StatsInfo from '../../viewmodel/StatsInfo'
import CalorieStats from './CalorieStats'
import DatePickDialog from './DatePickDialog'
import NutrientStats from './NutrientStats'

@Component
export default struct StatsCard {
  @Prop recommend: number
  @Prop recommendcarbon: number
  @Prop recommendprotein: number
  @Prop recommendfat: number
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM
  @Consume @Watch('handleRecordsChange') records: RecordVO[]
  @State info: StatsInfo = new StatsInfo()

  handleRecordsChange() {
    this.info = RecordService.calculateStatsInfo(this.records)
  }

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
      .padding(10)
      .onClick(() => {
        this.controller.open()
      })

      // 统计信息
      Swiper() {
        // 热量信息
        CalorieStats({ intake: this.info.intake, expend: this.info.expend, recommend: this.recommend })
        // 营养素信息
        NutrientStats({
          carbon: this.info.carbon,
          protein: this.info.protein,
          fat: this.info.fat,
          recommendcarbon: this.recommendcarbon,
          recommendprotein: this.recommendprotein,
          recommendfat: this.recommendfat
        })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(18)
      .indicatorStyle({ selectedColor: $r('app.color.primary_color') })
      .displayCount(this.currentBreakpoint == 'lg' ? 2 : 1)
      .indicator(this.currentBreakpoint == 'lg' ? false : true)
    }
    .width('94%')
    .backgroundColor($r('app.color.stats_title_bgc'))
    .borderRadius(18)
  }
}
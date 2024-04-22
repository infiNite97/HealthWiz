import DateUtil from '../../common/utils/DateUtil'
import PreferenceUtil from '../../common/utils/PreferenceUtil'
import RecordService from '../../service/RecordService'
import RecordVO from '../../viewmodel/RecordVO'
import RecordList from './RecordList'
import SearchHeader from './SearchHeader'
import StatsCard from './StatsCard'

@Component
export default struct RecordIndex {
  @State Height: string = '170'
  @State Weight: string = '60'
  @State showPanel: boolean = false
  @State recommend: number = 2651
  @State recommendcarbon: number = 178
  @State recommendprotein: number = 60
  @State recommendfat: number = 66
  @State rcm: number = 2651
  @State rcb: number = 178
  @State rpr: number = 60
  @State rft: number = 66
  @Watch('aboutToAppear')
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  @Provide records: RecordVO[] = []
  @Prop @Watch('handlePageShow') isPageShow: boolean

  async handlePageShow() {
    if (this.isPageShow) {
      this.aboutToAppear()
    }
  }

  async aboutToAppear() {
    this.recommendcarbon = await PreferenceUtil.getPreferenceValue('recommendcarbon', this.recommendcarbon) as number
    this.recommendprotein = await PreferenceUtil.getPreferenceValue('recommendprotein', this.recommendprotein) as number
    this.recommendfat = await PreferenceUtil.getPreferenceValue('recommendfat', this.recommendfat) as number
    this.recommend = await PreferenceUtil.getPreferenceValue('recommend', this.recommend) as number
    this.records = await RecordService.queryRecordByDate(this.selectedDate)
  }

  build() {
    Column() {


      // 头部搜索栏
      SearchHeader()

      Row() {
        // 热量方案角标
        StatsCard({
          recommend: this.recommend,
          recommendcarbon: this.recommendcarbon,
          recommendprotein: this.recommendprotein,
          recommendfat: this.recommendfat
        })
        // 统计卡片
        this.DietPlanSign()
      }

      // 记录列表
      RecordList()
        .layoutWeight(1)
      // 热量方案Panel
      this.DietPlanPanel()

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }

  heigh() {
    let shengaos = []
    for (let index = 100; index <= 230; index++) {
      let shenggao = { value: `${index}` }
      shengaos.push(shenggao)
    }
    return shengaos
  }

  weigh() {
    let tizhongs = []
    for (let index = 25; index <= 150; index++) {
      let tizhong = { value: `${index}` }
      tizhongs.push(tizhong)
    }
    return tizhongs
  }

  @Builder
  DietPlanSign() {
    Row() {
      Text('热量方案')
        .fontColor('#7f5319')
        .fontSize(14)
        .fontWeight(500)
        .width(60)
      Image($r('app.media.ic_public_arrow_right'))
        .width(20)
        .fillColor('#ffcaa97e')
    }
    .height(26)
    .position({ x: 0, y: 40 })
    .backgroundColor('#fee5a6')
    .padding({ left: 6 })
    .borderRadius({ bottomRight: 18, topLeft: 18 })
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.showPanel = true
    })
  }

  @Builder
  DietPlanPanel() {
    Panel(this.showPanel) {

      Text('当前饮食方案')
        .fontSize(16)
        .fontWeight(500)
        .padding({ bottom: 10 })
      Column() {
        Row() {
          Text('请选择身高: ')
            .fontWeight(500)
          Column() {

            Select(this.heigh())
              .width(100)
              .value(this.Height)
              .optionFont({ size: 18 })
              .onSelect((idx, val) => {
                this.Height = val
                let BRM = 660 + (11.5 * parseInt(this.Weight)) + (3.4 * parseInt(this.Height))
                this.rcm = BRM * 1.375
                this.rcb = ((this.rft * 9) - (this.rpr * 4)) / 2
                this.rpr = parseInt(this.Weight)
                this.rft = (this.rcm * 0.75) * 0.3 / 9
              })

          }

          Text('cm')
            .fontWeight(500)
        }
        .backgroundColor(Color.White)
        .width('100%')
        .borderRadius(18)
        .padding(5)

        Row() {
          Text('请选择体重: ')
            .fontWeight(500)
          Column() {

            Select(this.weigh())
              .width(100)
              .value(this.Weight)
              .optionFont({ size: 18 })
              .onSelect((idx, val) => {
                this.Weight = val
                let BRM = 660 + (11.5 * parseInt(this.Weight)) + (3.4 * parseInt(this.Height))
                this.rcm = BRM * 1.375
                this.rcb = ((this.rft * 9) - (this.rpr * 4)) / 2
                this.rpr = parseInt(this.Weight)
                this.rft = (this.rcm * 0.75) * 0.3 / 9
              })

          }

          Text('kg')
            .fontWeight(500)
        }
        .width('100%')
        .borderRadius(18)
        .padding(5)


        Column({ space: 8 }) {

          Text('预算热量')
            .fontSize(16)
            .fontWeight(500)
          Row({ space: 5 }) {
            Text(this.rcm.toFixed(0))
              .fontSize(44)
              .fontWeight(700)
              .fontColor($r('app.color.primary_color'))
              .decoration({ type: TextDecorationType.Underline })
            Text('千卡')
              .fontSize(18)
              .fontColor($r('app.color.primary_color'))
              .padding({ top: 10 })
          }
          .padding({ top: 20 })
        }
        .width('100%')
        .padding({ top: 20 })

        Blank()
        Row() {
          Button('取消')
            .width(100)
            .backgroundColor($r('app.color.light_gray'))
            .type(ButtonType.Normal)
            .borderRadius(10)
            .onClick(() => {
              this.showPanel = false
            })
          Button('确定')
            .width(100)
            .backgroundColor($r('app.color.primary_color'))
            .type(ButtonType.Normal)
            .borderRadius(10)
            .onClick(() => {
              this.showPanel = false
              this.recommend = this.rcm
              this.recommendcarbon = this.rcb
              this.recommendprotein = this.rpr
              this.recommendfat = this.rft
              PreferenceUtil.putPreferenceValue('recommend', this.recommend)
              PreferenceUtil.putPreferenceValue('recommendcarbon', this.recommendcarbon)
              PreferenceUtil.putPreferenceValue('recommendprotein', this.recommendprotein)
              PreferenceUtil.putPreferenceValue('recommendfat', this.recommendfat)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ bottom: 20 })

        Text('*预算热量是根据您的基础代谢率、日常活动方式和达到目标体重的所需的热量缺口计算得出的每日热量推荐值')
          .fontSize(12)
          .fontColor($r('app.color.light_gray'))
      }
      .backgroundColor(Color.White)
      .padding(10)
      .borderRadius(18)
      .width('100%')
      .height(400)
    }
    .width('94%')
    .backgroundColor($r('app.color.index_page_background'))
    .mode(PanelMode.Full)
    .dragBar(false)
  }
}
import RecordList from './RecordList'
import SearchHeader from './SearchHeader'
import StatsCard from './StatsCard'

@Component
export default struct RecordIndex {
  @State Height: string = '170'
  @State Weight: string = '60'
  @State showPanel: boolean = false
  @State recommend: number = 1862
  @State rcm: number = 1862

  build() {
    Column() {


      // 头部搜索栏
      SearchHeader()

      Row() {
        StatsCard({ recommend: this.recommend })
        this.DietPlanSign()
      }

      RecordList()
        .layoutWeight(1)

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
        .fontSize(16)
        .fontWeight(500)
      Image($r('app.media.ic_public_arrow_right'))
        .width(20)
        .fillColor('#ffcaa97e')
    }
    .position({ x: 0, y: 40 })
    .backgroundColor('#fee5a6')
    .padding(8)
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
                this.rcm = 660 + (11.5 * parseInt(this.Weight)) + (3.4 * parseInt(this.Height))
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
                this.rcm = 660 + (11.5 * parseInt(this.Weight)) + (3.4 * parseInt(this.Height))
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
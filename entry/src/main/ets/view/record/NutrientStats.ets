import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct NutrientStats {
  carbon: number = 23
  protein: number = 9
  fat: number = 7
  recommendcarbon: number = CommonConstants.RECOMMEND_CARBON
  recommendprotein: number = CommonConstants.RECOMMEND_PROTEIN
  recommendfat: number = CommonConstants.RECOMMEND_FAT

  build() {
    Row({ space: 6 }) {
      this.statsBuilder('碳水化合物',
        this.carbon,
        this.recommendcarbon,
        $r('app.color.carbon_color')
      )
      this.statsBuilder('蛋白质',
        this.protein,
        this.recommendprotein,
        $r('app.color.protein_color')
      )
      this.statsBuilder('脂肪',
        this.fat,
        this.recommendfat,
        $r('app.color.fat_color')
      )


    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder
  statsBuilder(label: string, value: number, recommend: number, color: ResourceStr) {
    Column({ space: 6 }) {

      Stack() {
        Progress({
          value: value,
          total: recommend,
          type: ProgressType.Ring
        })
          .width(90)
          .style({ strokeWidth: 6 })
          .color(color)
        Column({ space: 6 }) {

          Text('摄入推荐')
            .fontSize(12)
            .fontColor($r('app.color.light_gray'))
          Text(`${value.toFixed(0)}/${recommend.toFixed(0)}`)
            .fontSize(18)
            .fontWeight(600)
        }
      }

      Text(`${label}(克)`)
        .fontSize(12)
        .fontColor($r('app.color.light_gray'))
    }

  }
}
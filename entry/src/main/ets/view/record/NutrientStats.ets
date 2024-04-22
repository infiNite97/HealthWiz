import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct NutrientStats {
  @Prop carbon: number
  @Prop protein: number
  @Prop fat: number
  @Prop recommendcarbon: number
  @Prop recommendprotein: number
  @Prop recommendfat: number

  build() {
    Row({ space: 6 }) {
      this.statsBuilder({
        label: '碳水化合物',
        value: this.carbon,
        recommend: this.recommendcarbon,
        color: $r('app.color.carbon_color')
      })
      this.statsBuilder({
        label: '蛋白质',
        value: this.protein,
        recommend: this.recommendprotein,
        color: $r('app.color.protein_color')
      })
      this.statsBuilder({
        label: '脂肪',
        value: this.fat,
        recommend: this.recommendfat,
        color: $r('app.color.fat_color')
      })


    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder
  statsBuilder($$: {
    label: string,
    value: number,
    recommend: number,
    color: ResourceStr
  }) {
    Column({ space: 6 }) {

      Stack() {
        Progress({
          value: $$.value,
          total: $$.recommend,
          type: ProgressType.Ring
        })
          .width(90)
          .style({ strokeWidth: 6 })
          .color($$.color)
        Column({ space: 6 }) {

          Text('摄入推荐')
            .fontSize(12)
            .fontColor($r('app.color.light_gray'))
          Text(`${$$.value.toFixed(0)}/${$$.recommend.toFixed(0)}`)
            .fontSize(18)
            .fontWeight(600)
        }
      }

      Text(`${$$.label}(克)`)
        .fontSize(12)
        .fontColor($r('app.color.light_gray'))
    }

  }
}
@Component
export default struct CalorieStats {
  @Prop intake: number
  @Prop expend: number
  @Prop recommend: number

  build() {
    Row({ space: 6 }) {


      this.statsBuilder({ label: '饮食摄入', value: this.intake })

      Stack() {
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        })
          .width(130)
          .style({ strokeWidth: 8 })
          .color($r('app.color.primary_color'))
        this.statsBuilder({
          label: '还可以吃',
          value: (this.recommend - this.intake + this.expend),
          tips: `推荐预算${(this.recommend).toFixed(0)}`
        })
      }

      this.statsBuilder({ label: '运动消耗', value: this.expend })


    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })

  }

  @Builder
  statsBuilder($$: {
    label: string,
    value: number,
    tips?: string
  }) {
    Column({ space: 6 }) {
      Column({ space: 6 }) {
        Text($$.label)
          .fontColor($r('app.color.gray'))
          .fontWeight(600)
        Text($$.value.toFixed(0))
          .fontSize(22)
          .fontWeight(700)
      }
      .justifyContent(FlexAlign.Center)

      if ($$.tips) {
        Text($$.tips)
          .fontSize(12)
          .fontColor($r('app.color.light_gray'))
      }
    }

  }
}

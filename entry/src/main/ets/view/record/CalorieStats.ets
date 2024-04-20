@Component
export default struct CalorieStats {
  intake: number = 192
  expend: number = 150
  recommend: number = 1962

  build() {
    Row({ space: 6 }) {
      this.statsBuilder('饮食摄入', this.intake)

      Stack(){
        Progress({
          value: this.intake,
          total: this.recommend,
          type: ProgressType.Ring
        })
          .width(130)
          .style({strokeWidth:8})
          .color($r('app.color.primary_color'))

        this.statsBuilder('还可以吃', (this.recommend - this.intake + this.expend), `推荐预算${this.recommend}`)
      }

      this.statsBuilder('运动消耗', this.expend)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder
  statsBuilder(label: string, value: number, tips?: string) {
    Column({ space: 6 }) {
      Column({ space: 6 }) {
        Text(label)
          .fontColor($r('app.color.gray'))
          .fontWeight(600)
        Text(value.toFixed(0))
          .fontSize(20)
          .fontWeight(700)
      }
      .justifyContent(FlexAlign.Center)

      if (tips) {
        Text(tips)
          .fontSize(12)
          .fontColor($r('app.color.light_gray'))
      }
    }

  }
}